class HomeController < ApplicationController
  def index
    userTags = current_user.tags
    @maxLength = Tag.biggerTag(userTags)
    @tags = userTags.all
    @websites = current_user.websites.all
  end
end
