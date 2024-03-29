class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
  
  validates_uniqueness_of :group_id, scope: :user_id #同一のgroup_idに対するuser_idは一意である
end
