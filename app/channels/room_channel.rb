class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{current_user.room_id}"
    # ActionCable.server.broadcast 'room_channel', message: 'connected.'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	Message.create! content: data['message'], room_id: current_user.room_id, user_id: current_user.id
  	# ActionCable.server.broadcast 'room_channel', message: data['message']
  end
end
