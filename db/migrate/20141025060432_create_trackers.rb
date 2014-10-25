class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.integer :ticket_id
      t.text :ticket_changes
      t.string :updated_by

      t.timestamps
    end
  end
end
