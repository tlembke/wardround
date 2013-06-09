class Patient < ActiveRecord::Base
  attr_accessible :admission, :discharge, :name, :ward_id, :reason, :note, :mrn, :status, :under
  belongs_to :ward
  has_many :visits

  
  def visit(round)
    @visit=Visit.find(:all,:conditions=>["patient_id=? and round_id=?",self.id,round])
    debugger
  end
  
  def visited?(round)
    Visit.find(:all,:conditions=>["patient_id=? and round_id=?",self.id,round]).present?
  end
  
end
