class AddColumnDgToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :dg1, :string
    add_column :terms, :dg2, :string
  end
end
