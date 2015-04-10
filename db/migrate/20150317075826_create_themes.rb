class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.integer :nodeID
      t.string :contentID
      t.text :html_content 
      t.timestamps null: false     
    end
    
    add_index   :themes, :contentID, unique: true  
    add_foreign_key :themes, :nodes, column: :nodeID, primary_key: :nodeID, on_delete: :nullify 
  end
end
