class Theme < ActiveRecord::Base
  belongs_to :node
  has_one :metadata
  
  accepts_nested_attributes_for :metadata, reject_if: :all_blank
end
