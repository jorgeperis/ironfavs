class Tag < ApplicationRecord
  has_many :tag_websites
  has_many :websites, through: :tag_websites

  has_many :tag_users
  has_many :users, through: :tag_users

  belongs_to :color
  validates :name, :presence => true


 def insertColor(userTags)
    if userTags.all.empty?
      color = Color.first
    else
      if Color.exists? id: userTags.last.color.id + 1
        color = Color.find(userTags.last.color.id + 1)
      else
        color = Color.first
      end
    end
    self.color = color
  end

  def uniqueTag(userTags)
    if userTags.find_by('lower(name) = ?', self.name.downcase)
      "The name already exists"
    else
      self.insertColor(userTags)
      if self.save
        userTags.push(self)
        return "Done"
      else
        self.errors.full_messages
      end
    end
  end

  def self.biggerTag(userTags)
    biggestTag = userTags.sort { |x,y| y.websites.length <=> x.websites.length }.first
    if biggestTag
      biggestTag.websites.length
    else
      0
    end
  end
end
