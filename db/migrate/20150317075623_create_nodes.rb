class CreateNodes < ActiveRecord::Migration
  
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
    
     add_index :nodes, :nodeID, unique: true 
  end
end
