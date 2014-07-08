class Visit < ActiveRecord::Base
  attr_accessible :date, :doctor_id, :duration, :item, :notes, :patient_id, :ward_id
  belongs_to :doctor
  belongs_to :ward
  belongs_to :patient
  
  def self.code(patient,theDate)
    
    @visits=Visit.find(:all,:conditions=>["patient_id=? and date=?",patient,theDate.strftime('%Y-%m-%d')])
    code=" "
    if @visits.count>0
      code=@visits.count
    end

  end
end
