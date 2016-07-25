class Website < ApplicationRecord
  has_many :user_websites
  has_many :users, through: :user_websites

  has_many :tag_websites
  has_many :tags, through: :tag_websites

  validates :url, :presence => true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def mechanize(url)
    mechanize = Mechanize.new
    mechanize.get(url)
  end

  def getWebShot(page)
    ws = Webshot::Screenshot.instance
    ws.capture page.uri.to_s, "image.png", width: 300, height: 300, quality: 85
  end

  def validate(userWebsites,url,website)
    page = mechanize(url)
    if userWebsites.find_by url: page.uri.to_s
      "Page already exists in your database"
    else
      website.url = page.uri.to_s
      website.name = page.title
      website.avatar = File.new(getWebShot(page).path, "r")
      website.save
      userWebsites.push(website)
      "Done"
    end
  end
end
