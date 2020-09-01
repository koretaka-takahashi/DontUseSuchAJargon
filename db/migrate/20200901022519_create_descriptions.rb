class CreateDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptions do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :term, foreign_key: true

      t.timestamps
    end
  end
end
