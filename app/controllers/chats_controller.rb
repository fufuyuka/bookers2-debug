class ChatsController < ApplicationController
before_action :following_check, only: [:show]
  
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    room = @chat.room
    @chats = room.chats
  end

  private
    def chat_params
        params.require(:chat).permit(:message,:room_id)
    end

    def following_check
      user = User.find(params[:id])
      unless current_user.following?(user) && user.following?(current_user)
        redirect_to user_path(user)
      end
    end
  
end
