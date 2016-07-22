# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ws = Webshot::Screenshot.instance
a = ws.capture "http://www.ironhack.com/", "image.png", width: 300, height: 300, quality: 85
b = ws.capture "http://www.meneame.net/", "image.png", width: 300, height: 300, quality: 85
c = ws.capture "http://www.terra.es/", "image.png", width: 300, height: 300, quality: 85
d = ws.capture "http://www.xataka.com/", "image.png", width: 300, height: 300, quality: 85
e = ws.capture "http://www.mibrujula.com/", "image.png", width: 300, height: 300, quality: 85
f = ws.capture "http://www.genbetadev.com/", "image.png", width: 300, height: 300, quality: 85
g = ws.capture "https://www.codecademy.com/", "image.png", width: 300, height: 300, quality: 85
h = ws.capture "http://stackoverflow.com/", "image.png", width: 300, height: 300, quality: 85
i = ws.capture "http://www.jorgeperis.es/", "image.png", width: 300, height: 300, quality: 85
j = ws.capture "http://www.marca.es/", "image.png", width: 300, height: 300, quality: 85


Website.create(url: "http://www.ironhack.com/",name: "Ironhack",:avatar => File.new(a.path, "r"))
Website.create(url: "http://www.meneame.net/",name: "Meneame",:avatar => File.new(b.path, "r"))
Website.create(url: "http://www.terra.es/",name: "Terra",:avatar => File.new(c.path, "r"))
Website.create(url: "http://www.xataka.net/",name: "Xataka",:avatar => File.new(d.path, "r"))
Website.create(url: "http://www.mibrujula.com/",name: "Mibrujula",:avatar => File.new(e.path, "r"))
Website.create(url: "http://www.genbetadev.com/",name: "Genbeta",:avatar => File.new(f.path, "r"))
Website.create(url: "https://www.codecademy.com/",name: "Codecademy",:avatar => File.new(g.path, "r"))
Website.create(url: "http://stackoverflow.com/",name: "StackOverFlow",:avatar => File.new(h.path, "r"))
Website.create(url: "http://www.jorgeperis.es/",name: "jorgeperis",:avatar => File.new(i.path, "r"))
Website.create(url: "http://www.yonkis.com/",name: "Yonkis",:avatar => File.new(j.path, "r"))



Tag.create(name: "Code", color: "#ppp")
