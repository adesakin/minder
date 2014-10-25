class AddWorkflowStateToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :workflow_state, :string
  end
end
