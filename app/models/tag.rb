class Tag < ApplicationRecord
  has_many :tag_websites
  has_many :websites, through: :tag_websites

  has_many :tag_users
  has_many :users, through: :tag_users

  belongs_to :color
  validates :name, :presence => true

  def self.change_tag_size(current_user,tag,max)
    case tag.websites.length
      when 0...(0.2*max) then tag.size = 1
      when (0.2*max)...(0.4*max) then tag.size = 2
      when (0.4*max)...(0.6*max) then tag.size = 3
      when (0.6*max)...(0.8*max) then tag.size = 4
    else tag.size = 5
    end
    tag.save
  end

end
