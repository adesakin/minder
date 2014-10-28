class Ticket < ActiveRecord::Base
  after_create :set_reference
  before_save :update_ticket_status

  has_many :replies, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :replies, :reject_if => :all_blank, :allow_destroy => true
  validate :customer_name, :customer_email, :subject, :body, presence: true
  validates_email_format_of :customer_email, :message => 'Your Email Address is not compliant with RFC standards'



  scope :search, ->(q) {
    unless q.nil?
      where('ref like ? or lower(subject) like ? or lower(body) like ?', "%#{q.downcase}%", "%#{q.downcase}%", "%#{q.downcase}%")
    end
  }


  include Workflow

  workflow do
    state :new do
      event :open, :transitions_to => :open
    end

    state :open do
      event :open, :transitions_to => :open
      event :hold, :transitions_to => :hold
      event :closed, :transitions_to => :closed
    end

    state :hold do
      event :open, :transitions_to => :open
      event :hold, :transitions_to => :hold
      event :closed, :transitions_to => :closed
    end

    state :closed

  end

  def hold
    status = "On Hold"
  end

  def closed
    status = "Completed"
  end

  def self.open_tickets
    where(workflow_state: 'open')
  end

  def self.new_unassigned_tickets
    where(workflow_state: 'new')
  end

  def self.on_hold_tickets
    where(workflow_state: 'hold')
  end

  def self.closed_tickets
    where(workflow_state: 'closed')
  end


  private

  def set_reference
    status = "Unassigned" if status.nil?  #Only used for testing but reverted

    t = "0"
    until (t.nil?)
      u = unique_id
      t = self.class.where(ref: unique_id).take
    end
    update(ref: u)
  end

  def unique_id
    "#{[*('A'..'Z')].sample(3).join}-#{SecureRandom.hex(1)}-#{[*('A'..'Z')].sample(3).join}-#{SecureRandom.hex(1)}-#{[*('A'..'Z')].sample(3).join}".upcase
  end

  def update_ticket_status
    if status_changed?
      case status
      when "On Hold"
        self.hold!
      when "Cancelled"
        self.closed!
      when "Completed"
        self.closed!
      else
        self.open! unless new_record?
      end
    end
  end
end
