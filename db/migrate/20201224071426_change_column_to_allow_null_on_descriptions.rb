class ChangeColumnToAllowNullOnDescriptions < ActiveRecord::Migration[5.2]
  def up
    change_column :descriptions, :user_id, :bigint, null: true
  end

  def down
    change_column :descriptions, :user_id, :bigint, null: false
  end
end
