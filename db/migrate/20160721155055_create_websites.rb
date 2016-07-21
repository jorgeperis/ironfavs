class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
      t.string :url
      t.string :name
      t.timestamps
    end
  end
end
