class AddColorIdToTagUser < ActiveRecord::Migration[5.0]
  def change
    add_column :tag_users, :tag_color, :integer
  end
end
