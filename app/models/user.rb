class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, :presence => true

  has_many :user_websites
  has_many :websites, through: :user_websites

  has_many :tag_users
  has_many :tags, through: :tag_users

  has_many :tag_websites

  def max_websites_for_a_tag
    tags.map { |tag| tag.websites.count }.max
  end

end
