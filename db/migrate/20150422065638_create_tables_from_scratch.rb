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
        t.belongs_to :node, index: true
        t.string :contentID
        t.text :html_content
        t.boolean :more_about
        t.boolean :is_original
        t.timestamps null: false
      end

       create_table :metadata do |t|
        t.belongs_to :theme, index: true
        t.string :language
        t.string :title
        t.string :description
        t.string :keywords
        t.timestamps null: false
      end

      add_foreign_key :themes, :nodes, column: :node_id, primary_key: :id, on_delete: :nullify
      add_foreign_key :metadata, :themes, column: :theme_id, primary_key: :id, on_delete: :cascade

   end
end