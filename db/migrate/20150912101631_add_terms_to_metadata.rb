class AddTermsToMetadata < ActiveRecord::Migration
  def change
    add_column :metadata, :term1_id, :integer
    add_column :metadata, :term2_id, :integer
    add_column :metadata, :term3_id, :integer
  end
end
