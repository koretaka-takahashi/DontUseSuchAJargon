class ChangeColumnToAllowNullOnTags < ActiveRecord::Migration[5.2]
  def up
    change_column :tags, :user_id, :bigint, null: true
  end

  def down
    change_column :tags, :user_id, :bigint, null: false
  end
end
