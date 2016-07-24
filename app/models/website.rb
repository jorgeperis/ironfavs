class Website < ApplicationRecord
  has_many :user_websites
  has_many :users, through: :user_websites

  has_many :tag_websites
  has_many :tags, through: :tag_websites

  validates :url, :presence => true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
