class RemoveDepartmentIdFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :department_id, :integer
    add_column :tickets, :department, :string
  end
end
