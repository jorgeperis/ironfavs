
colorsName = ['default', 'primary', 'info', 'success', 'warning', 'danger']

colorsName.each do |name|
  Color.create(name: name)
end
