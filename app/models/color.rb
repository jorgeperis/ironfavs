class Color < ApplicationRecord
  validates :hex, :presence => true, :uniqueness => true
  has_many :tags
end
