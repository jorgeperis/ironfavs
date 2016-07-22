class CreateTagUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_users do |t|
      t.references :tag, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
