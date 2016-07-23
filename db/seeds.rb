# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
mechanize = Mechanize.new
ws = Webshot::Screenshot.instance

urls = ["http://www.ironhack.com/",
        "http://www.meneame.net/",
        "http://www.xataka.com/",
        "http://www.mibrujula.com/",
        "http://www.genbetadev.com/",
        "https://www.codecademy.com/",
        "http://stackoverflow.com/",
        "http://www.jorgeperis.es/",
        "http://www.marca.es/",
        "http://www.kakaomedia.com/"]

urls.each do |url|
  webshot = ws.capture url, "image.png", width: 300, height: 300, quality: 85
  page = mechanize.get(url)
  Website.create(url: url,name: page.title,:avatar => File.new(webshot.path, "r"))
end

Tag.create(name: "Code", color: "#ppp")

colors = ['#113F8C', '#01A4A4', '#00A1CB', '#61AE24', '#D0D102',
          '#32742C', '#D70060', '#E54028', '#F18D05', '#616161']
colors.each do |color|
  Color.create color: color
end
