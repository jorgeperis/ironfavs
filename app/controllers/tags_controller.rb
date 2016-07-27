class TagsController < ApplicationController

  def create
    userTags = current_user.tags
    tag = Tag.new(name: params[:tag][:name])
    if tag.uniqueTag(userTags) == "Done"
      redirect_to root_path
    else
      render text: tag.uniqueTag(userTags)
    end
  end
end
