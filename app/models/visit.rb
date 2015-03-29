class Visit < ActiveRecord::Base
 
  belongs_to :doctor
  belongs_to :ward
  belongs_to :patient
  
  def self.code(patient,theDate)
    # code is blank if no visits, 0 if visited but no charge, 1 if one visit, 2 if 2 on same day, etc
    @visits=Visit.where(["patient_id=? and date=?",patient,theDate.strftime('%Y-%m-%d')])
    code=" "

    if @visits.count>0
      chargeCount=0;
      @visits.each do |visit|
        if visit.item!="0"
          chargeCount=chargeCount+1
        end
      end
      code=chargeCount.to_s
    end
    return code




  end

  def doctor
      if self.doctor_id
        doctor=User.find(self.doctor_id)
        return doctor.name
      end
  end
end
