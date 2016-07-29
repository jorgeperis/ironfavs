class HomeController < ApplicationController

  def index
    @usertags = TagUser.where(user_id: current_user.id).decorate
    @userwebsites = UserWebsite.where(user_id: current_user.id).decorate
    @max_websites_tag = current_user.max_websites_for_a_tag
  end

end
