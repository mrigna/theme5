class AddDepthCachingForTerm < ActiveRecord::Migration
  def change
    add_column :terms, :ancestry_depth, :integer, :default => 0
  end
end
