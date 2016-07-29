class HomeController < ApplicationController

  def index
    @usertags = TagUser.where(user_id: current_user.id).decorate
    @userstags = TagUser.where(user_id: current_user.id)
    @userwebsites = UserWebsite.where(user_id: current_user.id).decorate
    @max_websites_tag = current_user.max_websites_for_a_tag
    @tags_websites = TagWebsite.where(user_id: current_user.id)
  end

end
