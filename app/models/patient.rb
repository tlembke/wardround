class Patient < ActiveRecord::Base
  attr_accessible :admission, :discharge, :name, :ward_id, :reason, :note, :mrn, :status
  belongs_to :ward
  has_many :visits
  
  def self.inpatients(date=Date.today)
    @patients = Patient.joins(:ward => :hospital).order("hospitals.id").find(:all,:conditions=>["admission <=? and (discharge is NULL or discharge=?)",date,date])
    #@patients=Patient.find(:all, :order =>"wards.hospital")
  end
  
  def visit(claim)
    @visit=Visit.find(:all,:conditions=>["patient_id=? and claim_id=?",self.id,claim])
  end
  
  def visited?(claim)
    Visit.find(:all,:conditions=>["patient_id=? and claim_id=?",self.id,claim]).present?
  end
end
