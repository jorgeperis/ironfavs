class WebsitesController < ApplicationController
  before_action :variables_for_view, only: :index

  def create
    url = params[:website][:url]
    url = "http://#{url}" unless url=~/^https?:\/\//
    website = Website.new
    begin
       website.try_to_save(current_user,url)
       redirect_to root_path
    rescue => e
      flash[:error] = e
      redirect_to root_path
    end
  end

  def index
    userwebsites = UserWebsite.for_user(current_user)
    suggest = params[:suggest]
    selectedtag = params[:selectedtag]

    if suggest && selectedtag

      suggestion = userwebsites.where(website_name: params[:suggest])
      selected = userwebsites
      selectedtag.each do |usertagid|
        tag = TagUser.find(usertagid).tag
        websites_with_tag = TagWebsite.for_user(current_user).where(tag_id: tag.id).select(:website_id)
        selected = selected.where(website_id: websites_with_tag)
      end
      result = suggestion & selected

    elsif suggest
      result = userwebsites.where(website_name: params[:suggest])
    elsif selectedtag
      result = userwebsites
      selectedtag.each do |usertagid|
        tag = TagUser.find(usertagid).tag
        websites_with_tag = TagWebsite.for_user(current_user).where(tag_id: tag.id).select(:website_id)
        result = result.where(website_id: websites_with_tag)
      end
    else
      result = userwebsites
    end
    @userwebsites = userwebsites.where(id: result).decorate
    respond_to do |format|
      format.js
      format.html
    end

  end


protected

  def variables_for_view
    @tags_websites = TagWebsite.for_user(current_user)
    @all_user_websites = UserWebsite.for_user(current_user).pluck(:website_name)
    @user_tags = current_user.tag_users
    @user_tags_decorate = @user_tags.decorate
    @max_websites_tag = current_user.max_websites_for_a_tag

  end

end
