class AddRoundIdToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :round_id, :integer
  end
end
