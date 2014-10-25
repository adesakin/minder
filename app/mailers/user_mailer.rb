class UserMailer < ActionMailer::Base
  default from: "from@host-tastic.com"

  def customer_mail(ticket)
    @greeting = "Hi"
    @ticket = ticket
    @url = customer_ticket_url(id: @ticket.id)
    mail(to: @ticket.customer_email, subject: @ticket.subject)
  end

  def customer_reply_mail(reply)
    @reply = reply
    @ticket = @reply.ticket
    @url = customer_ticket_url(id: @ticket.id)
    mail(to: @ticket.customer_email, subject: @ticket.subject)
  end

end
