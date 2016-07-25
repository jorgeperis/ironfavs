class AddNameToColor < ActiveRecord::Migration[5.0]
  def change
    add_column :colors, :name, :string
  end
end
