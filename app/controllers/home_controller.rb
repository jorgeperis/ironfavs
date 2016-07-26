class HomeController < ApplicationController

  def index
    userTags = current_user.tags
    @maxLength = Tag.biggerTag(userTags)
    @tags = userTags.all
    @websites = current_user.websites.all
  end

  def addTagToWebsite
    website = Website.find(params[:website_id].to_i)
    tag = Tag.find(params[:tag_id].to_i)
    unless tag.websites.find_by(id: website.id)
      website.tags.push(tag)
    end
    redirect_to root_path
  end
end
