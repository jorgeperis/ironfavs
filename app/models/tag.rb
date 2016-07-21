class Tag < ApplicationRecord
  has_many :tag_websites
  has_many :websites, through: :tag_websites
end
