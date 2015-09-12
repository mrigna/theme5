class Metadata < ActiveRecord::Base
  belongs_to :theme
  has_many :terms  

 private

    def self.ransackable_attributes(auth_object = nil)
      ["language", "title", "description", "keywords"] 
    end

end
