class ReplayJob < ActiveJob::Base
  queue_as :default

  def perform(options = {})
    scope = EventSearch.new(options).scope
    Replay.new(scope).replay
  end
end
