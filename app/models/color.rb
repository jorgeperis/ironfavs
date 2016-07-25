class Color < ApplicationRecord
  validates :name, :presence => true, :uniqueness => true
  has_many :tags
end
