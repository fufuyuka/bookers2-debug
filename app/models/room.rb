class Room < ApplicationRecord
  has_many :user_rooms
  has_many :users, through: :user_rooms #無くていい？
  has_many :chats
  #throughオプションによりuser_rooms(中間テーブル)経由でusersにアクセスできるようになる
  #room.usersでアクセスができる
end
