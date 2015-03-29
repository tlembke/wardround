class Hospital < ActiveRecord::Base

  has_many :wards
  has_many :rounds
  has_many :claims
  
  def inpatients(theDate=Date.today)
     @inpatients = Patient.joins(:ward => :hospital).where("hospital_id=?",self.id).where(["admission <=? and (discharge is NULL or discharge>=?)",theDate,theDate])

  end
  
  def patients(startDate,endDate)
     # @patients= Patient.inHospitalThisMonth(self.id,@month,@year)

       #Patient.find(:all,:conditions=>["admission>? and ?",Date.parse(year.to_s+"-"+month.to_s+"-01").strftime("%Y-%m-%d"),wardStr])
      @patients = Patient.joins(:ward => :hospital).where("hospital_id=?",self.id).where(["admission<= ? and (discharge is NULL or discharge >= ?)",endDate.strftime("%Y-%m-%d"),startDate.strftime("%Y-%m-%d")])
  end
end
