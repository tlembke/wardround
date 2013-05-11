class Ward < ActiveRecord::Base
  attr_accessible :hospital_id, :name
  has_many :patients
  belongs_to :hospital
  has_many :visits
  default_scope order('hospital_id ASC')
  
end
