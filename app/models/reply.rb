class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  after_save :send_reply_mail

  validate :note, presence: true

  def send_reply_mail
    UserMailer.customer_reply_mail(self).deliver
  end



end
