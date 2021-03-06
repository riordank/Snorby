class SigClass < ActiveRecord::Base
  set_table_name 'sig_class'
  set_primary_key "sig_class_id"
  has_many :signatures, :dependent => :destroy
  has_many :events, :through => :signatures, :dependent => :destroy

  def events_for_category
    self.signatures.collect { |sig| sig.events }.flatten.uniq.size
  end
  
  def all_even_nil
    data = []
    for s in SigClass.all(:order => 'sig_class_name')
      data << [s.sig_class_name, s.sig_class_id]
    end
    data << ["Unclassified", 0]
    return data
  end
  
end