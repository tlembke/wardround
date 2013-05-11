class AddDurationAndItemToHospitals < ActiveRecord::Migration
  def change
    add_column :hospitals, :duration, :integer
    add_column :hospitals, :item, :string
  end
end
