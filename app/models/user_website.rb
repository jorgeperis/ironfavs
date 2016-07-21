class UserWebsite < ApplicationRecord
  belongs_to :website
  belongs_to :user
end
