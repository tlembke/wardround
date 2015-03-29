class Round < ActiveRecord::Base
  has_many :claims
  belongs_to :hospital
  # round is a date and number - in case mpre than one ward round is done per day
  
  # Gets latest round for today, or creates new round if doesn/t exist
  def self.today(doctor)
    @round=Round.where('date=? and doctor_id=?',Date.today,doctor).order("created_at DESC")[0]
    if @round.blank?
      @round=Round.new
      @round.date=Date.today
      @round.number=1
      @round.start=Time.now
      @round.save
    end
    return @round
  end
  
  def inpatients
     @patients = Patient.joins(:ward => :hospital).where("hospital_id=?",self.hospital_id).where(["admission <=? and (discharge is NULL or discharge>=?)",self.date,self.date])
     #@patients = Patient.joins(:ward => :hospital).where("hospital_id=?",self.hospital_id).where(["admission <=? and (discharge is NULL or discharge>=?)",self.date,self.date],:order=>"ward_id ASC")

  end
  
  
  def self.ondate(date,order="DESC",hospital,doctor)
      @round=Round.where('date=? AND hospital_id=? and doctor_id=?',date,hospital,doctor).order("created_at "+order)[0]
      if @round.blank?
        @round=Round.new 
        @round.date=date
        @round.number=1
        if hospital
          @round.hospital_id=hospital
        elsif Hospital.count==1
          @round.hospital_id=Hospital.first.id
        end
        @round.doctor_id=doctor
        @round.save
      end

      return @round
      
    end  
  
  
  def previous(doctor)
      round=0
      if self.number>1
        @round=Round.where('date=? and number=? and hospital_id=? and doctor_id=?',self.date,self.number-1,self.hospital_id,doctor)[0]
        round=@round.id
      end
      return round
  end
  
  def visits(doctor)
      Round.where('date=? AND hospital_id=? AND doctor_id=?',self.date,self.hospital_id,doctor).count
  end
  
  def next(doctor)
      round=0

      if self.visits(doctor)>self.number
        @round=Round.where('date=? and number=? and doctor_id=?',self.date,self.number+1,doctor)[0]
        if @round 
          round=@round.id
        end
      end
      return round
  end

  def return
      @round=Round.new
      @round.hospital_id=self.hospital_id
      @round.date=self.date
      @round.number=self.visits(self.doctor_id)+1
      @round.start=Time.now
      @round.doctor_id=self.doctor_id
      @round.save
      return @round
  end    
end
