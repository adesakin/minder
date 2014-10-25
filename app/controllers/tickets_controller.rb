class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :control]
  before_filter :authenticate_user!, except: [:create]
  respond_to(:html)

  def index
    redirect_to tickets_manage_path
  end

  def show
    respond_with(@ticket)
  end

  # def new
  #   @ticket = Ticket.new
  #   respond_with(@ticket)
  # end

  # def edit
  # end

  # def create
  #   @ticket = Ticket.new(ticket_params)
  #   @ticket.save
  #   respond_with(@ticket)
  #   UserMailer.customer_mail(@ticket).deliver  #just to save time and avoid all the long delayed_job + cousins
  # end

  def update
    if (@ticket.user == current_user) && (params[:ticket][:user])
      @user = User.find_by_email(params[:ticket][:user])
      @ticket.user = @user unless @user.nil?
    end
    @ticket.update(ticket_params)
    respond_with(@ticket)
  end

  def destroy
    @ticket.destroy
    respond_with(@ticket)
  end

  def manage
    @tickets = Ticket.all
  end

  def search
    filter = params[:filter]
    query = params[:query]
    @tickets = Ticket.where('status = ?',  filter)
    respond_to do |format|
      format.html {render action: 'manage'}
    end
  end

  def control
    current_user.tickets << @ticket
    @ticket.own_ticket!
    respond_to do |format|
      format.html {render action: 'show', notice: "You are now own this ticket"}
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:customer_name, :customer_email, :department, :subject, :body, :status, \
        replies_attributes: [:note])
    end
end
