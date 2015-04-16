class Patient < ActiveRecord::Base
  
  belongs_to :ward
  has_many :visits

  
  def visit(round)
    @visit=Visit.where(["patient_id=? and round_id=?",self.id,round]).first
  end
  
  def visited?(round)
    Visit.where(["patient_id=? and round_id=?",self.id,round]).present?
  end
  
  def charged?(round)
    Visit.where(["patient_id=? and round_id=? and item>0",self.id,round]).present?
  end
  
  def charge_icon(round)
    icon="";
    if Visit.where(["patient_id=? and round_id=? and item>0",self.id,round]).present?
      icon="c";
    end
    return icon
  end
  
  def under_icon
    icon=""
    if self.under==1
      icon="u"
    end
    return icon
  end
  
  def icons(round)
    icon="";
    if Visit.where(["patient_id=? and round_id=? and item>0",self.id,round]).present?
      icon+="c";
    end
    if self.under==1
      icon+="u"
    end
    @round=Round.find(round)
    if self.discharge == @round.date
      icon+="d"
    end
    return icon
  end
  
  def status_text
      r="Unknown"
      r="Public" if self.status==1
      r="Private" if self.status==2
      r="DVA" if self.status==3
      r="Workcover" if self.status==4
      return r
  end

  def item(round)
    charge=0
    @visit=Visit.where(["patient_id=? and round_id=?",self.id,round]).first
    if @visit
      charge=@visit.item
    end
    return charge
  end
  
  def otherHospitals
      Hospital.where(["id!=? ",self.ward.hospital.id])
  end
  

  

  def self.inThisMonth(month,year)
      Patient.where(["admission>?",Date.parse(year.to_s+"-"+month.to_s+"-01").strftime("%Y-%m-%d")])
  end
  
  def self.inHospitalThisPeriod(hospital,theDate=Date.today,period="month")
      @wards=Ward.where(["hospital_id=?",hospital])
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
      Patient.where(["admission< ? and (discharge='' or discharge >= ?) and #{wardStr}",firstDay.strftime("%Y-%m-%d"),lastDay.strftime("%Y-%m-%d")])
      #Patient.find(:all,:conditions=>[wardStr])
  end

  # How many visits this period, how many charged
  
  def visitsBilled
      count=Visit.where(["patient_id=? and billed =?",self.id,true]).count
      return count
  end

  def visitsTotal
      count=Visit.where(["patient_id=?",self.id]).count
      return count
  end

  def visitsCharged
      count=Visit.where(["patient_id=? and item>0",self.id]).count
      return count
  end


  
end
