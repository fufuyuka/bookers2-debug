class RoomsController < ApplicationController
  #before_action :matchers!
  
  def create
    room = UserRoom.where(room_id: current_user, room_id: params[:user_id])
    redirect_to room_path(room)
     #条件に合うチャットルームが存在しない場合、新規作成
    if room.blank? 
      new_room=Room.create
      UserRoom.create(user_id: current_user.id, room_id: room.id)
      UserRoom.create(user_id: params[:user_id], room_id: room.id)
    end
    redirect_to room_path(new_room)
  end
  
  def show
  end
  
end
