class PruebaController < ActionController::Base
  def index
    ws = Webshot::Screenshot.instance
    a = ws.capture "http://www.ironhack.com/", "google.png", width: 300, height: 300, quality: 85

    @prueba = Website.create(url: "http://www.ironhack.com/",name: "Google",:avatar => File.new(a.path, "r"))
  end

  def show
    @a = Website.all
  end
end
