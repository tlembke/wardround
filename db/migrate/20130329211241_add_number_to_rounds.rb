class AddNumberToRounds < ActiveRecord::Migration
  
    change_table :rounds do |t|
      t.integer :number
    end
  
end
