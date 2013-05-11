class Visit < ActiveRecord::Base
  attr_accessible :date, :doctor_id, :duration, :item, :notes, :patient_id, :ward_id
  belongs_to :doctor
  belongs_to :ward
  belongs_to :patient
end
