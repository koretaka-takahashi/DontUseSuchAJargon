class CreateKeeps < ActiveRecord::Migration[5.2]
  def change
    create_table :keeps do |t|
      t.references :user, foreign_key: true, null: false
      t.references :term, foreign_key: true, null: false

      t.timestamps
    end
  end
end
