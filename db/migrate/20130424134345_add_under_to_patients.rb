class AddUnderToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :under, :integer
  end
end
