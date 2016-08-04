class Website < ApplicationRecord
  has_many :user_websites
  has_many :users, through: :user_websites

  has_many :tag_websites
  has_many :tags, through: :tag_websites

  validates :url, :presence => true
  validates_uniqueness_of :url

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def self.find_or_create_by_page(url)
    page = Mechanize.new.get(url)

    find_or_initialize_by(url: page.uri.to_s) do |new_website|
      new_website.name = page.title
      new_website.avatar = avatar_for_page(new_website.url)
    end
  end

  private

  def self.avatar_for_page(url)
    File.new(
      Webshot::Screenshot.
        instance.
        capture(url, "image.png", width: 300, height: 300, quality: 85).
        path,
      "r")
  end
end
