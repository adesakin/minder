class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :customer_name
      t.string :customer_email
      t.integer :department_id
      t.string :subject
      t.text :body
      t.string :ref

      t.timestamps
    end
  end
end
