class EventsController < ApplicationController

  def index
    @event_search = EventSearch.new(params)
    @events = @event_search.search
  end

  def show
    @event = Event.find(params[:id])
  end

  def replay
    @event = Replay.new(Event.find(params[:id])).replay
    redirect_to @event, notice: 'Event replayed successfully'
  end

end
