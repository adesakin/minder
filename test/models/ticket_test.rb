require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  test "has attributes" do

  end

  test "set reference" do
    ticket = tickets(:one)
    ticket.save
    assert_match "Unassigned", ticket.status
    
    ref_reg = /^[A-Z]{3}-\h\h-[A-Z]{3}-\h\h-[A-Z]{3}$/i
    refute_nil ref_reg.match(ticket.ref)
  end

end
