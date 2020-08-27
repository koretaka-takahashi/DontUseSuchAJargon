class CreateTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :terms do |t|
      t.string :name
      t.references :user, foreign_key: true, null: false
      t.references :genre, foreign_key: true, null: false

      t.timestamps
    end
  end
end
