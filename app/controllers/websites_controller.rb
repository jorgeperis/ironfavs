class WebsitesController < ApplicationController
  before_action :variables_for_view, only: :index

  def create
    url = params[:website][:url]
    url = "http://#{url}" unless url=~/^https?:\/\//
    begin
      website = Website.find_or_create_by_page(url)
      current_user.websites.push(website)
    rescue => e
      flash[:error] = e
    end
    redirect_to root_path
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
      if params[:inputtext] == "" || params[:inputtext] == nil
        result = userwebsites
       else
        result = []
      end
      selectedtag.each do |usertagid|
        tag = TagUser.find(usertagid).tag
        websites_with_tag = TagWebsite.for_user(current_user).where(tag_id: tag.id).select(:website_id)
        result = result.where(website_id: websites_with_tag) if result != []
      end
    else
      if params[:inputtext] == "" || params[:inputtext] == nil
        result = userwebsites
       else
        result = []
      end
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
