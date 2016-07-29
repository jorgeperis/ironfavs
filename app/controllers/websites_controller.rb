class WebsitesController < ApplicationController
  def create
    url = params[:website][:url]
    url = "http://#{url}" unless url=~/^https?:\/\//
    website = Website.new
    begin
      website.try_to_save(current_user,url)
      redirect_to root_path
    rescue => e
      render text: e
    end

  end
end
