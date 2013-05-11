class AddMrnAndStatustoPatients < ActiveRecord::Migration
  def change
    add_column :patients, :mrn, :string
    add_column :patients, :status, :integer
  end


end
