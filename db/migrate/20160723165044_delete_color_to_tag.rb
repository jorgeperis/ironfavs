class DeleteColorToTag < ActiveRecord::Migration[5.0]
  def change
    remove_column :tags, :color
  end
end
