class Tag < ApplicationRecord
  has_many :tag_websites
  has_many :websites, through: :tag_websites

  has_many :tag_users
  has_many :users, through: :tag_users

  belongs_to :color
  validates :name, :presence => true
end
