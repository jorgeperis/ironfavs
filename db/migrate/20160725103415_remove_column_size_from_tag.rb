class RemoveColumnSizeFromTag < ActiveRecord::Migration[5.0]
  def change
    remove_column :tags, :size
  end
end
