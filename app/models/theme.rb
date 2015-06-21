class Theme < ActiveRecord::Base
  belongs_to :node
  has_one :metadata

  #default_scope { order('"id" ASC') }

  scope :node, -> (id) { where(node_id: id)}


  accepts_nested_attributes_for :metadata, reject_if: :all_blank


  private

    def self.ransackable_attributes(auth_object = nil)
      ["html_content", "more_about", "is_original"] 
    end

end