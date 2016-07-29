class WebsitesController < ApplicationController
  def create
    userWebsites = current_user.websites
    url = params[:website][:url]
    url = "http://#{url}" unless url=~/^https?:\/\//
    website = Website.new
    begin
      page = website.mechanize(url)
      website.url = page.uri.to_s
      website.name = page.title
      website.avatar = File.new(website.getWebShot(page).path, "r")
    rescue => e
      render text: e
    end
    website.try_to_save(userWebsites,current_user)
    redirect_to root_path
  end
end
