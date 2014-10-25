class Ticket < ActiveRecord::Base
  before_create :set_reference

  has_many :replies, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :replies, :reject_if => :all_blank, :allow_destroy => true
  validate :customer_name, :customer_email, :subject, :body, presence: true
  validates_email_format_of :customer_email, :message => 'Your Email Address is not compliant with RFC standards'


  searchable do
    text :ref, :subject
    text :replies do
      replies.map { |reply| reply.note }
    end
  end

  include Workflow

  workflow do
    state :new do
      event :own_ticket, :transitions_to => :open
    end

    state :open do
      event :revert, :transitions_to => :new
      event :submit, :transitions_to => :closed
    end

    state :on_hold do
      event :open, :transitions_to => :open
    end

    state :closed

  end


  def self.open_tickets
    where(workflow_state: 'open')
  end

  def self.new_unassigned_tickets
    where(workflow_state: 'new')
  end

  def self.on_hold_tickets
    where(workflow_state: 'on_hold')
  end

  def self.closed_tickets
    where(workflow_state: 'closed')
  end



  private

  def set_reference
    status = "Unassigned" if status.nil?  #Only used for testing but reverted
    if ref.nil?
      t = "0"
      until (t.nil?)
        u = unique_id
        t = self.class.where(ref: unique_id).take
      end
      self.ref = u
    else
      ref
    end
  end

  def unique_id
    "#{[*('A'..'Z')].sample(3).join}-#{SecureRandom.hex(1)}-#{[*('A'..'Z')].sample(3).join}-#{SecureRandom.hex(1)}-#{[*('A'..'Z')].sample(3).join}".upcase
  end




end
