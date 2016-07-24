class WebsiteController < ApplicationController
  def new
    @website = Website.new
  end

  def create
    mechanize = Mechanize.new
    ws = Webshot::Screenshot.instance

    url = params[:website][:url]
    url = "http://#{url}" unless url=~/^https?:\/\//

    begin
      page = mechanize.get(url)

      if current_user.websites.find_by url: page.uri.to_s
        a = "Page already exists in your database"
        render text: a
      else
        @website = Website.new(url: page.uri.to_s,name: page.title)
        if @website.save
          webshot = ws.capture page.uri.to_s, "image.png", width: 300, height: 300, quality: 85
          @website.avatar = File.new(webshot.path, "r")
          @website.save
          current_user.websites.push(@website)
          redirect_to '/websites/show'
        else
          render text: @website.errors[:url]
        end
      end

    rescue => e
      render text: e
    end
  end

  def show
    @websites = current_user.websites.all
  end

end
