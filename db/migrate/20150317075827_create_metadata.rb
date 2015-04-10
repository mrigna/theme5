class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.string :contentID
      t.string :language
      t.string :title
      t.string :description
      t.string :keywords
      t.timestamps null: false
    end   
  end
end
