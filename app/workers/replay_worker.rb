class ReplayWorker

  include Sidekiq::Worker

  def perform(options = {})
    scope = EventSearch.new(options).scope
    Replay.new(scope).replay
  end

end
