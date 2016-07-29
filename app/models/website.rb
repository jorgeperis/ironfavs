class Website < ApplicationRecord
  has_many :user_websites
  has_many :users, through: :user_websites

  has_many :tag_websites
  has_many :tags, through: :tag_websites

  validates :url, :presence => true
  validates_uniqueness_of :url

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def mechanize(url)
    mechanize = Mechanize.new
    mechanize.get(url)
  end

  def getWebShot(mechanize_page)
    ws = Webshot::Screenshot.instance
    ws.capture mechanize_page.uri.to_s, "image.png", width: 300, height: 300, quality: 85
  end


  def try_to_save(user,url)
    page = mechanize(url)
    self.url = page.uri.to_s
    self.name = page.title
    if self.save
      self.avatar = File.new(getWebShot(page).path, "r")
      self.save
      user.websites.push(self)
    else
      existing_website = Website.find_by(url: self.url)
      UserWebsite.create(user_id: user.id,website_id: existing_website.id)
    end
  end
end
