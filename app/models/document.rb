class Document < ActiveRecord::Base
  belongs_to :node
  
  hstore_accessor :doc_attributes,
  url: :string,
  type: :string,
  title: :string,  
  author: :string,
  account: :string,
  keywords: :string,
  description: :string,
  extension: :string,
  name_file: :string,
  shc_themes: :string 
end
