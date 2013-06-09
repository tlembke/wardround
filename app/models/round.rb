class Round < ActiveRecord::Base
  attr_accessible :claimable, :date, :doctor_id, :duration, :finish, :hospital_id, :start
  has_many :claims
  belongs_to :hospital
  # round is a date and number - in case mpre than one ward round is done per day
  
  # Gets latest round for today, or creates new round if doesn/t exist
  def self.today
    @round=Round.where('date=?',Date.today).order("created_at DESC")[0]
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
     @patients = Patient.joins(:ward => :hospital).where("hospital_id=?",self.hospital_id).find(:all,:conditions=>["admission <=? and (discharge is NULL or discharge=?)",self.date,self.date],:order=>"ward_id ASC")
  end
  
  
  def self.ondate(date,order="DESC",hospital)
      @round=Round.where('date=? AND hospital_id=?',date,hospital).order("created_at "+order)[0]
      if @round.blank?
        @round=Round.new 
        @round.date=date
        @round.number=1
        if hospital
          @round.hospital_id=hospital
        elsif Hospital.count==1
          @round.hospital_id=Hospital.first.id
        end
        @round.save
      end

      return @round
      
    end  
  
  
  def previous
      round=0
      if self.number>1
        @round=Round.where('date=? and number=? and hospital_id=?',self.date,self.number-1,self.hospital_id)[0]
        round=@round.id
      end
      return round
  end
  
  def visits
      Round.where('date=? AND hospital_id=?',self.date,self.hospital_id).count
  end
  
  def next
      round=0
      if self.visits>self.number
        @round=Round.where('date=? and number=?',self.date,self.number+1)[0]
        round=@round.id
      end
      return round
  end

  def return
      @round=Round.new
      @round.hospital_id=self.hospital_id
      @round.date=self.date
      @round.number=self.visits+1
      @round.start=Time.now
      @round.save
      return @round
  end    
end
