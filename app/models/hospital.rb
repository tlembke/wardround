class Hospital < ActiveRecord::Base
  attr_accessible :name, :showtime, :duration, :item
  has_many :wards
  has_many :rounds, :through => :claims
  has_many :claims

end
