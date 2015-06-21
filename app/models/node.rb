class Node < ActiveRecord::Base
  has_many :themes

  default_scope { order('"nodeID" ASC') }

  def settings
    return (super == "true") if %w{true false}.include? super
    super
  end

  def url_label_and_dg
    '   ' + nodeID.to_s + ' -- ' + dg + ' -- ' + url_label
  end

  scope :dg, -> (name_dg) { where(dg: name_dg) }
  scope :user, -> (user_dg) { where(dg: user_dg) }

  store_accessor :label_translations, :fr, :nl, :de, :en
  store_accessor :references, :law, :form, :FAQ, :divers, :links

  private
    def self.ransackable_attributes(auth_object = nil)
       ["nodeID", "url_label", "dg"]
    end

end