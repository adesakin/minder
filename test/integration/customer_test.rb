require 'test_helper'

class CustomerTest < ActionDispatch::IntegrationTest


  test "submit query with email generated" do
    visit customer_index_path
    click_link('New Ticket')
    fill_in "Customer Name", with: Faker::Name.name
    email = Faker::Internet.email
    fill_in "Customer Email", with: email
    #select('sample', from: "Department")
    subject = Faker::Lorem::sentence
    fill_in "Subject", with: subject
    fill_in "Issue Details", with: Faker::Lorem::paragraph(2)
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      click_button('Create Issue Ticket')
    end
    t = Ticket.last
    current_path.must_equal customer_ticket_path(id: t.id)

    md = ActionMailer::Base.deliveries.last
    md.subject.must_equal subject
    md.to[0].must_equal email
    
  end
end
