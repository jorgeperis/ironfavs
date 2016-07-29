class UserWebsitesController < ApplicationController

  def update
    user_website = UserWebsite.find(params[:id])
    user_website.website_name = params[:web_name]
    user_website.save
  end

  def destroy
    user_website = UserWebsite.find(params[:id])
    website = user_website.website_id
    current_user.websites.delete(website)
    tagwebsite = TagWebsite.where(website_id: website,user_id: current_user.id).destroy_all
    user_website.destroy
    redirect_to root_path
  end
end
