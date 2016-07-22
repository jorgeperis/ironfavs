class Color < ApplicationRecord
  validates :color, :presence => true, :uniqueness => true
end
