class RoomController < ApplicationController
  before_action :require_user
  skip_after_action :logout
  after_action :render_member, only: :show

  def show
  	@messages = Message.where(room_id: params[:id])
    users = User.room_users(params[:id])
    @owner = users[:owner]
    @entrant = users[:entrant]
    Rails.logger.debug("owner ---" + @owner.inspect)
    Rails.logger.debug("entrant ---" + @entrant.inspect)
  end

  private

    def require_user
  	  if current_user.present?
        redirect_to root_path, error: "チャットルームが違います" if params[:id] != current_user.room_id.to_s
   	  else
   	    redirect_to root_path, error: "まだチャットに参加していません"
   	  end
    end
    def render_member
      Rails.logger.debug("params_id --- " + params[:id])
      users = User.room_users(params[:id])
      MemberBroadcastJob.perform_later(users[:owner], users[:entrant]) if users[:owner].present? || users[:entrat].present?
    end
end
