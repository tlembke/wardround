class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :ward_id
      t.date :admission
      t.date :discharge

      t.timestamps
    end
  end
end
