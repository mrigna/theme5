class AddMissingFieldsToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :check_dg, :boolean
    add_column :themes, :check_com, :boolean
  end
end
