class ChangeNameNullOnTerms < ActiveRecord::Migration[5.2]
  def change
    change_column :terms, :name, :string, null: false
  end
end
