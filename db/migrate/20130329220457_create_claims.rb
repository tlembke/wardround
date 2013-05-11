class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.date :date
      t.integer :hospital_id
      t.integer :doctor_id
      t.integer :round_id
      t.integer :duration
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
