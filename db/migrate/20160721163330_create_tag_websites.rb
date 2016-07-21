class CreateTagWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_websites do |t|
      t.references :tag, index: true
      t.references :website, index: true
      t.timestamps
    end
  end
end
