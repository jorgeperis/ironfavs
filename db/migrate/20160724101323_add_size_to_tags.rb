class AddSizeToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :size, :integer, :default => 1
  end
end
