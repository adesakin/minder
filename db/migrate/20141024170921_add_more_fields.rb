class AddMoreFields < ActiveRecord::Migration
  def change
    add_column :tickets, :user_id, :integer
    add_column :replies, :ticket_id, :integer
  end
end
