class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.references :genre, foreign_key: true, null: false

      t.timestamps
    end
  end
end
