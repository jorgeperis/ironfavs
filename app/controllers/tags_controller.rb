class TagsController < ApplicationController

  def create
    userTags = current_user.tags
    tag = Tag.new(name: params[:tag][:name].capitalize)
    tag.color = tag.insertColor(userTags)
    begin
      tag.try_to_save(userTags,current_user)
      redirect_to root_path
    rescue => e
      render text: e
    end
  end
end
