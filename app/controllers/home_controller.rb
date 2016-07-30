class HomeController < ApplicationController
  before_filter :userwebsites, :only => [:index]
  before_filter :usertags, :userstags, :max_websites_tag, :tags_websites, :only => [:index, :search, :search_by_tags]

  def index
  
  end

  def search
    unless params[:search] == ''
      @userwebsites = UserWebsite.search params[:search], :with => {:user_id => current_user.id}
      tagswebsites = TagWebsite.search params[:search], :with => {:user_id => current_user.id}
      tagswebsites.each do |tagwebsite|
        @userwebsites.push(UserWebsite.find_by(user_id: tagwebsite.user_id,website_id: tagwebsite.website_id))
      end
      render 'index'
    else
      redirect_to root_path
    end
  end

  def search_by_tags
    @userwebsites = []
    id_tag = TagUser.find(params[:id]).tag_id.to_i
    tagwebsites = TagWebsite.where(user_id: current_user.id, tag_id: id_tag)
    tagwebsites.each do |tagwebsite|
      @userwebsites.push(UserWebsite.find(website_id: tagwebsite.website.id))
    end
    render 'index'
  end

  protected

    def userwebsites
      @userwebsites = UserWebsite.where(user_id: current_user.id).decorate
    end
    def usertags
      @usertags = TagUser.where(user_id: current_user.id).decorate
    end
    def userstags
      @userstags = TagUser.where(user_id: current_user.id)
    end
    def max_websites_tag
      @max_websites_tag = current_user.max_websites_for_a_tag
    end
    def tags_websites
      @tags_websites = TagWebsite.where(user_id: current_user.id)
    end
end
