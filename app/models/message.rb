class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }

  belongs_to :room

  validates :content, presence: true

end
