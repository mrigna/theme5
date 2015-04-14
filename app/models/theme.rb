class Theme < ActiveRecord::Base
  belongs_to :node
  has_one :metadata  
  
  accepts_nested_attributes_for :node
  accepts_nested_attributes_for :metadata
end