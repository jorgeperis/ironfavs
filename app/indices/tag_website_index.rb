ThinkingSphinx::Index.define :tag_website, :with => :real_time do
  # fields
  indexes tag.name, :as => :tag_name, :sortable => true

  # attributes
  has user_id,  :type => :integer
  has tag_id, :type => :integer
  has website_id, :type => :integer
end
