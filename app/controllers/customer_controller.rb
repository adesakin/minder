class CustomerController < ApplicationController

  def index

  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.status = "Waiting for Staff Response"
    respond_to do |format|
      if @ticket.save
        UserMailer.customer_mail(@ticket).deliver 
        format.html{redirect_to customer_ticket_path(id: @ticket.id), notice: 'Your ticket has been created with details below.'}
      else
        format.html{render action: 'new'}
      end
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.status = "Waiting for Staff Response"
    @ticket.update(reply_params)
    respond_to do |format|
      format.html {redirect_to customer_ticket_path(id: @ticket.id), notice: 'Your ticket has been updated.'}
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  private
  def reply_params
    params.require(:ticket).permit(replies_attributes: [:note])
  end

  def ticket_params
    params.require(:ticket).permit(:customer_name, :customer_email, :department, :subject, :body, :status, \
      replies_attributes: [:note])
  end
end