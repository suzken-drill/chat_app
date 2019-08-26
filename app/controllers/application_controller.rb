class ApplicationController < ActionController::Base
  include SessionHelper
  after_action :logout

  private
    def logout
      user = current_user
      if user.present?
        user.update(deleted_at: Time.zone.now)
        log_out
        users = User.room_users(user.room_id)
        MemberBroadcastJob.perform_later(users[:owner], users[:entrant]) if users[:owner].present? || users[:entrat].present?
      end
    end
end
