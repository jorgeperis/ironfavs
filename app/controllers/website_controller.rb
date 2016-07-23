class WebsiteController < ApplicationController
  def new
    @website = Website.new
  end

  def create
    mechanize = Mechanize.new
    ws = Webshot::Screenshot.instance

    url = params[:website][:url]
    url = "http://#{url}" unless url=~/^https?:\/\//
    website = Website.find_by url: url

    if website
      if website.users.find_by id: current_user.id
        a = "Website exists in your Websites list"
        render text: a
      else
        current_user.websites.push(website)
        redirect_to '/websites/show'
      end
    else
      begin
        Net::HTTP.get(URI(url))
        page = mechanize.get(url)
        @website = Website.new(url: url,name: page.title)

        if @website.save
          webshot = ws.capture url, "image.png", width: 300, height: 300, quality: 85
          @website.avatar = File.new(webshot.path, "r")
          @website.save
          current_user.websites.push(@website)
          redirect_to '/websites/show'
        else
          render text: @website.errors[:url]
        end

      rescue => e
        render text: e
      end

    end

  end

  def show
    @websites = current_user.websites.all
  end

end
