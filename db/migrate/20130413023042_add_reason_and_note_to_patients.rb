class AddReasonAndNoteToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :reason, :string
    add_column :patients, :note, :text
  end
end
