class Tag < ApplicationRecord
  has_many :tag_websites
  has_many :websites, through: :tag_websites

  has_many :tag_users
  has_many :users, through: :tag_users

  validates :name, :presence => true, :uniqueness => true
end
