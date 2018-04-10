class UserTicketsController < ApplicationController
  def create
    UserTicket.create(ticket_params)
  end
  def destroy
    ticket = UserTicket.find(params[:id])
    ticket.destroy
  end
  def update
    ticket = UserTicket.find(params[:id])
    ticket.update(ticket_params)
  end
  def show
    ticket = UserTicket.find(params[:id])
    render :json => ticket
  end
  def ticket_params
    params.require(:user_tickets).permit(:user_id, :ticket_id)
  end
end
