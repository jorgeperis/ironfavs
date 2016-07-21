class TagWebsite < ApplicationRecord
  belongs_to :website
  belongs_to :tag
end
