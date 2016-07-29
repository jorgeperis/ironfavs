class AddNametoUserWebsite < ActiveRecord::Migration[5.0]
  def change
    add_column :user_websites, :website_name, :string
  end
end
