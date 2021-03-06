class UserWebsite < ApplicationRecord
  belongs_to :website
  belongs_to :user
  before_create :name_website
  validates :website_id, uniqueness: {scope: :user_id}
  scope :for_user, ->(user) { where("user_id = ?", user.id) }

  def name_website
    self.website_name = Website.find(self.website_id).name
  end
end
