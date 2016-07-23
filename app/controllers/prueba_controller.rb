class PruebaController < ActionController::Base
  def index
    ws = Webshot::Screenshot.instance
    a = ws.capture "http://www.justeat.com/", "image.png", width: 300, height: 300, quality: 85
    @prueba = Website.create(url: "http://www.justeat.com",name: "JustEat",:avatar => File.new(a.path, "r"))
  end

  def show
    @a = Website.all
  end
end
