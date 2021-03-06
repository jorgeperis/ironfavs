class TagWebsitesController < ApplicationController

  def create
    tagwebsite = TagWebsite.new
    tagwebsite.tag_id = TagUser.find(params[:usertag_id]).tag_id
    tagwebsite.website_id = UserWebsite.find(params[:userwebsite_id]).website_id
    tagwebsite.user_id = current_user.id
    tagwebsite.save
    redirect_to root_path
  end

  def destroy
    TagWebsite.find(params[:id]).destroy
    redirect_to root_path
  end

end
