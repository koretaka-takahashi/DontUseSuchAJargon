class CreateDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptions do |t|
      t.text :content, null: false
      t.references :user, foreign_key: true, null: false
      t.references :term, foreign_key: true, null: false

      t.timestamps
    end
  end
end
