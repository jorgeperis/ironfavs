mechanize = Mechanize.new
ws = Webshot::Screenshot.instance

urls = ["http://www.meneame.net/",
        "http://stackoverflow.com/"]

urls.each do |url|
  webshot = ws.capture url, "image.png", width: 300, height: 300, quality: 85
  page = mechanize.get(url)
  Website.create(url: page.uri.to_s,name: page.title,:avatar => File.new(webshot.path, "r"))
end

colorsName = ['grey', 'pink', 'salmon', 'yellow', 'green', 'blue', 'darkblue', 'purple']

colorsName.each do |name|
  Color.create(name: name)
end
