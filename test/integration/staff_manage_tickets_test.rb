require 'test_helper'

class StaffManageTicketsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    visit tickets_manage_path
    user_sign_in
  end


  def teardown

  end

  test "view unassigned tickets" do
    skip "Fix Capybara CSS Issue"
    @tickets = Ticket.where(status: 'Unassigned')
    select('Unassigned', :from => 'filter')
    click_link('Search')
    ticket_ids =  tickets_listed
    ticket_ids.count.must_equal @tickets.count
    ticket_ids.sort.must_equal @tickets.sort.map {|p| p.id.to_s}
  end

  test "view open tickets" do
    #skip "Fix Capybara CSS Issue"
    @tickets = Ticket.where(status: 'Open')
    select('Open', :from => 'filter')
    click_link('Search')
    save_and_open_page
    ticket_ids =  tickets_listed
    ticket_ids.count.must_equal @tickets.count
    ticket_ids.sort.must_equal @tickets.sort.map {|p| p.id.to_s}
  end

  test "take ownership" do 
     
  end

  test "user replies ticket" do
    @ticket = Ticket.last
    visit customer_ticket_path(@ticket)
    para = Faker::Lorem::paragraph(1)
    fill_in "Work Note", :with => para
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      find('Update Ticket').click
    end
    @ticket.replies.must_include para
    
  end


  def tickets_listed
    page.all('ul#tickets li.ticket_id').map(&:text)
  end

end
