class WebsitesController < ApplicationController
  def index
    @websites = current_user.websites.all
  end

  def new
    @website = Website.new
  end

  def create
    userWebsites = current_user.websites
    url = params[:website][:url]
    url = "http://#{url}" unless url=~/^https?:\/\//
    website = Website.new

    begin
      if website.validate(userWebsites,url,website) == "Done"
        redirect_to root_path
      else
        render text: website.validate(userWebsites,url,website)
      end
    rescue => e
      render text: e
    end
  end
end
