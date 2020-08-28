class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :terms, :genre_id, :bigint, null: true
  end

  def down
    change_column :terms, :genre_id, :bigint, null: false
  end
end
