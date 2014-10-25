require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "customer_mail" do
    mail = UserMailer.customer_mail(tickets(:mail_ticket)).deliver
    assert_equal "Customer Mailer Ticket", mail.subject
    assert_equal ["customerm@test.com"], mail.to
    assert_equal ["from@host-tastic.com"], mail.from
  end

end
