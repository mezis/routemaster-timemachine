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

  def replay_event
    @event = Event.find(params[:id])

    Replay.new(Event.where(id: @event.id)).replay
    redirect_to @event, notice: 'Event replayed successfully'
  end

  def replay_events
    @events = EventSearch.new(params[:event_search] || {})

    Replay.new(@events.scope).replay
    redirect_to events_path(params.slice(:event_search)), notice: 'Events replayed successfully'
  end

end
