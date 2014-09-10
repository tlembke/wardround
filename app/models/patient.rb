class Patient < ActiveRecord::Base
  attr_accessible :admission, :discharge, :name, :ward_id, :reason, :note, :mrn, :status, :under, :charge
  belongs_to :ward
  has_many :visits

  
  def visit(round)
    @visit=Visit.find(:all,:conditions=>["patient_id=? and round_id=?",self.id,round])
  end
  
  def visited?(round)
    Visit.find(:all,:conditions=>["patient_id=? and round_id=?",self.id,round]).present?
  end
  
  def charged?(round)
    Visit.find(:all,:conditions=>["patient_id=? and round_id=? and item>0",self.id,round]).present?
  end
  
  def otherHospitals
      Hospital.find(:all,:conditions=>["id!=? ",self.ward.hospital.id])
  end
  

  

  def self.inThisMonth(month,year)
      Patient.find(:all,:conditions=>["admission>?",Date.parse(year.to_s+"-"+month.to_s+"-01").strftime("%Y-%m-%d")])
  end
  
  def self.inHospitalThisPeriod(hospital,theDate=Date.today,period="month")
      @wards=Ward.find(:all,:conditions=>["hospital_id=?",hospital])
      wardStr="("
      @wards.each do |ward|
        wardStr=wardStr+"ward_id="+ward.id.to_s+" or "
      end
      wardStr=wardStr+ "ward_id=0)"
      firstDay=theDate.at_beginning_of_month
      if period=='week'
        firstDay=theDate.at_beginning_of_week
      end
      lastDay=theDate.at_end_of_month
      if period=='week'
        lastDay=theDate.at_end_of_week
      end
      #Patient.find(:all,:conditions=>["admission>? and ?",Date.parse(year.to_s+"-"+month.to_s+"-01").strftime("%Y-%m-%d"),wardStr])
      Patient.find(:all,:conditions=>["admission< ? and (discharge='' or discharge >= ?) and #{wardStr}",firstDay.strftime("%Y-%m-%d"),lastDay.strftime("%Y-%m-%d")])
      #Patient.find(:all,:conditions=>[wardStr])
  end
  
end
