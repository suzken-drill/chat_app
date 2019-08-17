class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
    # ActionCable.server.broadcast 'room_channel', message: 'connected.'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	Message.create! content: data['message']
  	# ActionCable.server.broadcast 'room_channel', message: data['message']
  end
end
