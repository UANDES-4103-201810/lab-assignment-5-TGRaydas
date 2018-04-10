class TicketsController < ApplicationController
  def create
    Ticket.create(ticket_params)
  end
  def destroy
    ticket = Ticket.find(params[:id])
    ticket.destroy
  end
  def update
    ticket = Ticket.find(params[:id])
    ticket.update(ticket_params)
  end
  def show
    ticket = Ticket.find(params[:id])
    render :json => ticket
  end
  def ticket_params
    params.require(:tickets).permit(:description, :price, :event_id)
  end
end
