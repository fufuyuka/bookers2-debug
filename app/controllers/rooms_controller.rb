class RoomsController < ApplicationController
  before_action :following_check
  
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id) #中間テーブルからcurrent_userのidがあるroom_idをピックアップ
    chat_room = UserRoom.find_by(user_id: @user.id, room_id: rooms) #↑のうち、@userのidを含むものを見つける
    
    if chat_room.nil? #nilの場合
      room = Room.new #新しくRoomを作成
      room.save
      UserRoom.create(user_id: current_user.id, room_id: room.id) #新しくUserRoom(中間テーブル)を作成!!二つ!!
      UserRoom.create(user_id: @user.id, room_id: room.id) #createは保存も同時に行われるのでsave不要
    else
      @room = chat_room.room
      @chats = @room.chats
      @chat = Chat.new(room_id: @room.id)
    end
  end
  
  private
    def following_check
      user = User.find(params[:id])
      unless current_user.following?(user) && user.following?(current_user)
        redirect_to user_path(current_user) #FFではない場合、Homeへ
      end
    end
  
end
