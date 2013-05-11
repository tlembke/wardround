class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :doctor_id
      t.integer :hospital_id
      t.date :date
      t.integer :duration
      t.integer :claimable
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
