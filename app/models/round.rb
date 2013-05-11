class Round < ActiveRecord::Base
  attr_accessible :claimable, :date, :doctor_id, :duration, :finish, :hospital_id, :start
  has_many :claims
  has_many :hospitals, :through => :claims
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
  
  def self.ondate(date,order="DESC")
      @round=Round.where('date=?',date).order("created_at "+order)[0]
      if @round.blank?
        @round=Round.new
        @round.date=date
        @round.number=1
        @round.save
      end

      return @round
      
    end  
  
  
  def previous
      round=0
      if self.number>1
        @round=Round.where('date=? and number=?',self.date,self.number-1)[0]
        round=@round.id
      end
      return round
  end
  
  def visits
      Round.where('date=?',self.date).count
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
      @round.date=self.date
      @round.number=self.visits+1
      @round.start=Time.now
      @round.save
      return @round
  end    
end
