class SessionController < ApplicationController
  skip_after_action :logout, only: :create

  def create
    @index_form = IndexForm.new(index_params)
    unless @index_form.valid?
      error_message = ""
      Rails.logger.debug(@index_form.errors.inspect)
      @index_form.errors.messages.each do |key, values|
        values.each do |value|
          error_message += "・#{value}<br>"
        end
      end
      flash[:error] = "<h5>チャットルームの入室に失敗しました</h5>" + error_message
      redirect_to root_path and return
    end
  	room_id = User.search_room_id.pluck(:room_id)[0]
    user = User.create_room_user(room_id, params[:name])
    if user.blank?
      flash[:error] = "チャットルームの入室に失敗しました"
      redirect_to root_path and return
    end
    log_in user
    redirect_to room_show_path(id: user.room_id), notice: "チャットルームに入室しました"
  end

  def destroy
    redirect_to root_path, notice: "退室しました"
  end

  private
    def index_params
      params.permit(:name)
    end

end
