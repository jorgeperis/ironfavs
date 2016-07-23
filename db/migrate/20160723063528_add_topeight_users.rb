class AddTopeightUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :topeight, :text, array: true, default: '{}'
  end
end
