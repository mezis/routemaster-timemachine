class EventsController < ApplicationController

  def index
    options = {}
    options.merge! ( params[:event_search] || {} )
    options.merge! params.slice(:page, :per_page)
    options.symbolize_keys!

    @event_search = EventSearch.new(options)
    @events       = @event_search.search
  end

  def show
    @event = Event.find(params[:id])
  end

  def replay
    @event = Replay.new(Event.find(params[:id])).replay
    redirect_to @event, notice: 'Event replayed successfully'
  end

end
