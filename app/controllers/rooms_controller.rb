class RoomsController < ApplicationController
  #before_action :matchers!
  
  def create
    current_users_rooms = UserRoom.where(user_id: current_user.id).map do |user_room|
      user_room.room 
    end
    
    room = UserRoom.where(room_id: current_users_rooms, user_id: params[:user_id])[0].room
     #条件に合うチャットルームが存在しない場合、新規作成
    if room.blank? 
      room = UserRoom.create
      UserRoom.create(user_id: current_user.id, room_id: room.id)
      UserRoom.create(user_id: params[:user_id], room_id: room.id)
    end
    redirect_to room_path(room)
  end
  
  def show
  end
  
end
