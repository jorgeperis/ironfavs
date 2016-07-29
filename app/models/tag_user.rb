class TagUser < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  before_create :tag_color_for_user
  validates :tag_id, uniqueness: {scope: :user_id}

  def tag_color_for_user
    self.tag_color = Tag.find(self.tag_id).color_id
  end

  def upload_color(color_id)
    self.tag_color = color_id
  end

end
