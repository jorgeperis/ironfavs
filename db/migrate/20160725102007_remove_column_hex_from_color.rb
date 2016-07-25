class RemoveColumnHexFromColor < ActiveRecord::Migration[5.0]
  def change
    remove_column :colors, :hex
  end
end
