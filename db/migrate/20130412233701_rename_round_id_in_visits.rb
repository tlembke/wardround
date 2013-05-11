class RenameRoundIdInVisits < ActiveRecord::Migration
  def up
    rename_column :visits, :round_id, :claim_id
  end

  def down
    rename_column :visits, :claim_id, :round_id
  end
end
