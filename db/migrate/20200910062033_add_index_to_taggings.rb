class AddIndexToTaggings < ActiveRecord::Migration[5.2]
  def self.up
    add_index :taggings, [:term_id, :tag_id], unique: true
  end 

  def self.down
    remove_index :taggings, [:term_id, :tag_id]
  end 
end
