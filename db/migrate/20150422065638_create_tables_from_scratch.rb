class CreateTablesFromScratch < ActiveRecord::Migration
   execute 'DROP EXTENSION hstore'    
  execute 'CREATE EXTENSION hstore'
  
    def change
      create_table :nodes do |t|
        t.integer :nodeID
        t.text :url_label
        t.boolean :hidden
        t.string :dg
        t.hstore :label_translations
        t.hstore :references     
        t.timestamps null: false    
      end
      
      create_table :themes do |t|
        t.belongs_to :nodes, index: true
        t.integer :nodeID
        t.string :contentID
        t.text :html_content 
        t.timestamps null: false     
      end
       
       create_table :metadata do |t|
        t.belongs_to :themes, index: true
        t.string :contentID
        t.string :language
        t.string :title
        t.string :description
        t.string :keywords
        t.timestamps null: false
      end
 
       add_index :nodes, :nodeID, unique: true 
       add_index   :themes, :contentID, unique: true  
       add_foreign_key :themes, :nodes, column: :nodeID, primary_key: :nodeID, on_delete: :nullify
       add_index   :metadata, :id, unique: true
       add_foreign_key :metadata, :themes, column: :contentID, primary_key: :contentID, on_delete: :cascade
    end
end