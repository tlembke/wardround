class Claim < ActiveRecord::Base

  belongs_to :round
  belongs_to :patient
  

end
