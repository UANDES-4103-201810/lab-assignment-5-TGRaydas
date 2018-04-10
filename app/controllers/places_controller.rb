class PlacesController < ApplicationController
  def create
    Place.create(place_params)
  end
  def destroy
    place = Place.find(params[:id])
    place.destroy
  end
  def update
    place = Place.find(params[:id])
    place.update(place_params)
  end
  def show
    place = Place.find(params[:id])
    render :json => place
  end
  def place_params
    params.require(:places).permit(:name, :address, :capacity)
  end
  def most_assistance
    places = Place.all
    return_places = []
    the_return_places = []
    places.each do |place|
      place_assistant = 0
      events = Event.where(:place_id => place.id)
      events.each do |event|
        tickets = Ticket.where(:event_id => event.id)
        place_assistant += tickets.length
      end
      dict = {"Name" => place.name, "Assistant" => place_assistant }
      return_places.append(dict)
      values.append(place_assistant)
    end
    values.each do |value|
      return_places.each do |place|
        if value == place["Assistant"] && the_return_places.length <= 10
          the_return_places.append(place)
        end
      end
    end
    render :json => return_places
  end

end
