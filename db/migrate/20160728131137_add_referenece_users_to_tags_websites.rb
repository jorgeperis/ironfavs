class AddRefereneceUsersToTagsWebsites < ActiveRecord::Migration[5.0]
  def change
    add_reference :tag_websites, :user, index: true
  end
end
