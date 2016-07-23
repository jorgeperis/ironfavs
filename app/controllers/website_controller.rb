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
      Net::HTTP.get(URI(url))
      page = mechanize.get(url)
      @website = Website.new(url: url,name: page.title)

      if @website.save
        webshot = ws.capture url, "image.png", width: 300, height: 300, quality: 85
        @website.avatar = File.new(webshot.path, "r")
        @website.save
        render :show
      else
        render text: @website.errors[:url]
      end

    rescue => e
      render text: e
    end
  end

end
