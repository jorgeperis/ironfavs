class UserWebsite < ApplicationRecord
  belongs_to :website
  belongs_to :user
  before_create :name_website
  validates :user_id, uniqueness: {scope: :website_id}

  def name_website
    self.website_name = Website.find(self.website_id).name
  end
end
