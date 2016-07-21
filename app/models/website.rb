class Website < ApplicationRecord
  has_many :user_websites
  has_many :users, through: :user_websites
  
  has_many :tag_websites
  has_many :tags, through: :tag_websites
end
