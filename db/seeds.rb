# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
mechanize = Mechanize.new
ws = Webshot::Screenshot.instance

urls = ["http://www.meneame.net/",
        "http://www.genbetadev.com/",
        "https://www.codecademy.com/",
        "http://stackoverflow.com/",
        "http://www.jorgeperis.es/",]

urls.each do |url|
  webshot = ws.capture url, "image.png", width: 300, height: 300, quality: 85
  page = mechanize.get(url)
  Website.create(url: page.uri.to_s,name: page.title,:avatar => File.new(webshot.path, "r"))
end

colors = ['#c9c9b6', '#ff8080', '#ffbf80', '#ffff80', '#9fff80', '#80dfff', '#8080ff', '#ff80ff'] 

colors.each do |color|
  Color.create(hex: color)
end
