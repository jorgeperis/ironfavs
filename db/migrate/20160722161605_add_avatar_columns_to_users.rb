class AddAvatarColumnsToUsers < ActiveRecord::Migration[5.0]
  def up
    add_attachment :websites, :avatar
  end

  def down
    remove_attachment :websites, :avatar
  end
end
