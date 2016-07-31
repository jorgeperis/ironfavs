class UserWebsite < ApplicationRecord
  belongs_to :website
  belongs_to :user
  before_create :name_website
  validates :user_id, uniqueness: {scope: :website_id}
  after_save ThinkingSphinx::RealTime.callback_for(:user_website)
  default_scope { order("#{self.table_name}.website_name ASC") }

  def name_website
    self.website_name = Website.find(self.website_id).name
  end
end
