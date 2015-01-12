class EventsController < ApplicationController

  def index
    @events = EventSearch.new(params).search
  end

  def show
    @event = Event.find(params[:id])
  end

  def replay
    @event = Replay.new(Event.find(params[:id])).replay
    redirect_to @event, notice: 'Event replayed successfully'
  end

end
