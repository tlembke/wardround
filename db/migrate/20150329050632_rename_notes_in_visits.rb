class RenameNotesInVisits < ActiveRecord::Migration
    change_table :visits do |t|
  		t.rename :notes, :chargenote
end
end
