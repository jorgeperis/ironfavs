ThinkingSphinx::Index.define :user_website, :with => :real_time do
  # fields
  indexes website_name, :sortable => true
  indexes website.url


  # attributes
  has user_id,  :type => :integer
  has website_id, :type => :integer
end
