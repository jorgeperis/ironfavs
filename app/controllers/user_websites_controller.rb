class UserWebsitesController < ApplicationController

  def update
    user_website = UserWebsite.find(params[:id])
    user_website.website_name = params[:web_name]
    user_website.save
    redirect_to root_path
  end

  def destroy
    userwebsite = UserWebsite.find(params[:id])
    TagWebsite.where(website_id: userwebsite.website,user_id: current_user.id).destroy_all
    userwebsite.destroy
    redirect_to root_path
  end
end
