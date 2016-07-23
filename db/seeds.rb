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
  Website.create(url: url,name: page.title,:avatar => File.new(webshot.path, "r"))
end

colors = ['#8eb2f1', '#80fefe', '#80e5ff', '#bbe995', '#fefe81',
          '#a7dca3', '#ff80b9', '#f19b8e', '#fcc982', '#bfbfbf']
colors.each do |color|
  Color.create(hex: color)
end
