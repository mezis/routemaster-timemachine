class EventsController < ApplicationController

  def index
    @events = EventSearch.new(params).search
  end

  def show
    @event = Event.find(params[:id])
  end

end
