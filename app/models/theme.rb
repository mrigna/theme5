class Theme < ActiveRecord::Base
  belongs_to :nodes
  has_many :metadata
end
