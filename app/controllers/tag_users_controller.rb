class TagUsersController < ApplicationController

  def update
    tag_user = TagUser.find(params[:id])
    tag_user.tag_color = Color.find_by(name: params[:color_name]).id
    tag_user.save
    redirect_to root_path
  end

  def destroy
    tag_user = TagUser.find(params[:id])
    tag = tag_user.tag_id
    current_user.tags.delete(tag)
    tagwebsite = TagWebsite.where(tag_id: tag,user_id: current_user.id).destroy_all
    tag_user.destroy
    redirect_to root_path
  end
end
