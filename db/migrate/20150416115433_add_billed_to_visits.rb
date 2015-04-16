class AddBilledToVisits < ActiveRecord::Migration
  def change
  	add_column :visits, :billed, :boolean
  end
end
