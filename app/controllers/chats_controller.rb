class ChatsController < ApplicationController

  
  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
    room = @chat.room
    @chats = room.chats
  end

  private
    def chat_params
        params.require(:chat).permit(:message,:room_id)
    end
  
end
