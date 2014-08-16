class AddChargeToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :charge, :integer
  end
end
