class Menu < ActiveRecord::Base
  has_many :terms
  belongs_to :nodes
  has_ancestry :cache_depth => true
  
  default_scope { order('"id" ASC') }
end
