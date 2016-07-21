class CreateUserWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :user_websites do |t|
      t.references :user, index: true
      t.references :website, index: true
      t.timestamps
    end
  end
end
