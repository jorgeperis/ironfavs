
colorsName = ['grey', 'pink', 'salmon', 'yellow', 'green', 'blue', 'darkblue', 'purple']

colorsName.each do |name|
  Color.create(name: name)
end
