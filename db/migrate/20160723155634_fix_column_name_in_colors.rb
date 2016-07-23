class FixColumnNameInColors < ActiveRecord::Migration[5.0]
  def change
    rename_column :colors, :color, :hex
  end
end
