class WebsitesController < ApplicationController

  def create
    userWebsites = current_user.websites
    url = params[:website][:url]
    url = "http://#{url}" unless url=~/^https?:\/\//
    website = Website.new
    begin
      if website.validate(userWebsites,url,website)
        redirect_to root_path
      else
        e = "Page already exists"
        render text: e
      end
    rescue => e
      render text: e
    end
  end

  def update
    website = Website.find(params[:id])
    website.name = params[:web_name]
    website.save
  end

  def destroy
    website = Website.find(params[:id])
    website.destroy
    redirect_to root_path
  end
end
