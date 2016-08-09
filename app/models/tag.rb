class Tag < ApplicationRecord
  has_many :tag_websites
  has_many :websites, through: :tag_websites

  has_many :tag_users
  has_many :users, through: :tag_users

  belongs_to :color
  validates :name, :presence => true
  validates_uniqueness_of :name

  def insertColor(userTags)
    if userTags.all.empty?
      Color.first
    else
      if Color.exists? id: userTags.last.color.id + 1
        Color.find(userTags.last.color.id + 1)
      else
        Color.first
      end
    end
  end

  def try_to_save(userTags,user)
    if self.save
      byebug
      userTags.push(self)
    else
      existing_tag = Tag.find_by(name: self.name)
      userTags.push(existing_tag)
      taguser = TagUser.find_by(user_id: user.id, tag_id: existing_tag.id)
      taguser.upload_color(insertColor(userTags).id)
    end
  end
end
