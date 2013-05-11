class Claim < ActiveRecord::Base
  attr_accessible :date, :doctor_id, :duration, :finish, :hospital_id, :round_id, :start, :claimable
  belongs_to :hospital
  belongs_to :round

end
