class Group < ApplicationRecord
  
  has_many :gorup_users, dependent: :destroy
  
  has_one_attached :group_image
  
  validates :name,presence:true,length:{maximum:20}
  validates :introduction,presence:true,length:{maximum:50}
  validates :owner_id, presence: true,numericality: :only_integer
end
