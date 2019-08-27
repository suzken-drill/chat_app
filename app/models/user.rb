class User < ApplicationRecord
  before_create :get_session_key

  has_many :messages
  belongs_to :room

  validates :name, presence: true
  validates :room_id, presence: true, if: :room_member_over?

  # constant
  MAX_WAIT_TIME = 180 # second

  # scope
  default_scope { where(deleted_at: nil) }
  scope :search_room_id, -> { unscoped.select(:room_id).where("created_at >= ?", Time.zone.now.ago(MAX_WAIT_TIME.seconds)).group(:room_id).having("count(*) < ?", Room::MAX_ROOM_MEMBER) }

  # 空きルームがなければルームとユーザーを作成、あればユーザーを作成
  def self.create_room_user(room_id, user_name)
    user = User.new
    if room_id.blank?
      begin
        transaction do
          room = Room.new
          room.save!
          user.room_id = room.id
          user.name = user_name
          user.save!
        end
      rescue => e
        return false
      end
    else
      begin
        user.room_id = room_id
        user.name = user_name
        user.save!
      rescue => e
        return false
      end
    end
    Rails.logger.debug("user --- " + user.inspect)
    return user
  end

#  def self.active_session_user(session_key)
#    where('created_at >= ?', Time.zone.now.ago(MAX_WAIT_TIME)).where(session_key: session_key).first
#  end

  def self.room_users(room_id)
    users = where(room_id: room_id).limit(2).order(:created_at)
    owner = users.first
    entrant = users.count > 1 ? users.last : nil
    return {owner: owner, entrant: entrant}
  end

  private

  def get_session_key
    self.session_key = SecureRandom.base64(10) if self.session_key.blank?
  end

  def room_member_over?
  	User.where(room_id: self.room_id).count <= 1
  end

end
