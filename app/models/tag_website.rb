class TagWebsite < ApplicationRecord
  belongs_to :website
  belongs_to :tag
  belongs_to :user

  validates :tag_id, uniqueness: {scope: [:user_id, :website_id]}
  scope :for_user, ->(user) { where("user_id = ?", user.id) }

  def self.count_websites_for_a_tag(user,tag)
    where(user_id: user, tag_id: tag).size
  end
end
