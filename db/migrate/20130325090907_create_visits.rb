class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.integer :ward_id
      t.date :date
      t.integer :duration
      t.string :item
      t.text :notes

      t.timestamps
    end
  end
end
