class AddShowimeToHospitals < ActiveRecord::Migration
  def change
    add_column :hospitals, :showtime, :boolean
  end
end
