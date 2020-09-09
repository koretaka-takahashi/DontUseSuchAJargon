class AddReferencesToTags < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :user, null: false, foreign_key: true
  end
end
