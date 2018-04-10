class EventsController < ApplicationController
  def create
    Event.create(event_params)
  end
  def destroy
    event = Event.find(params[:id])
    event.destroy
  end
  def update
    event = Event.find(params[:id])
    event.update(event_params)
  end
  def show
    event = Event.find(params[:id])
    render :json => event
  end
  def event_params
    params.require(:events).permit(:name, :description, :start_date, :place_id, :created_at, :updated_at)
  end
  def unpaid_tickets_event
    events = Event.all
    return_events = []
    return_event = {}
    events.each do |event|
      unpaid_tickets = 0
      tickets = Ticket.where(:event_id => event.id)
      tickets.each do |ticket|
        paid = UserTicket.where(:ticket_id => ticket.id, :paid => false).first
        if paid != nil
          unpaid_tickets += 1
        end
      end
      dict = {"Event" => event.name, "Tickets" => unpaid_tickets}
      return_events.append(dict)
    end
    most = -1
    return_events.each do |event|
      if event["Tickets"] > most
        most = event["Tickets"]
        return_event = event
      end
    end
    render :json => return_event
  end
  def most_expensive_tickets
    tickets = Ticket.where(:event_id => params[:id]).limit(10).order("price desc")
    render :json => tickets
  end
end
