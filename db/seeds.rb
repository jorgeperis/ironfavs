
colorsName = ['grey', 'red', 'salmon', 'yellow', 'green', 'blue', 'darkblue', 'purple', 'white']

colorsName.each do |name|
  Color.create(name: name)
end
