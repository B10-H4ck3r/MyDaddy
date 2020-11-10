class RoomChannel < ApplicationCable::Channel
    def subscribed
       stream_from "room_channel"
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end

    #the rest of the methods
    def speak(data)
      Message.create! content: data['message']
    end
end
