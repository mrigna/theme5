class Term < ActiveRecord::Base
  has_ancestry :cache_depth => true
  scope :lang, -> (lang) { where(language: lang) }
  scope :dg,   -> (dg) { where(dg1: dg) or where(dg2: dg)}
end