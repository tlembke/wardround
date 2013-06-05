class Hospital < ActiveRecord::Base
  attr_accessible :name, :showtime, :duration, :item
  has_many :wards
  has_many :rounds
  has_many :claims
  
  def inpatients
     @inpatients = Patient.joins(:ward => :hospital).where("hospital_id=?",self.id).find(:all,:conditions=>["admission <=? and (discharge is NULL or discharge=?)",Date.today,Date.today])
  end

end
