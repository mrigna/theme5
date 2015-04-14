class Node < ActiveRecord::Base
  has_many :themes
   
  default_scope { order('"nodeID" ASC')}
  
  def settings
    return (super == "true") if %w{true false}.include? super
    super
  end
    
  store_accessor :label_translations, :fr, :nl, :de, :en
  store_accessor :references, :law, :form, :FAQ, :divers, :links
 
  private
    
    def self.ransackable_attributes(auth_object = nil)
      ["nodeID", "url_label", "dg"] 
    end
   
end