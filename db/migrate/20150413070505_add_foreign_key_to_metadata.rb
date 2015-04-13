class AddForeignKeyToMetadata < ActiveRecord::Migration
  def change
    change_table :metadata do |t|
    add_foreign_key :metadata, :themes, column: :contentID, primary_key: :contentID, on_delete: :cascade 
    end
  end
end


    
