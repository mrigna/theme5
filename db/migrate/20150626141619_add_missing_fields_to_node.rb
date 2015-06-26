class AddMissingFieldsToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :group, :string 
  end
end
