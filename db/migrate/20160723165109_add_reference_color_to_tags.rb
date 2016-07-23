class AddReferenceColorToTags < ActiveRecord::Migration[5.0]
  def change
    add_reference :tags, :color, index: true
  end
end
