class Sweeper

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly.minute_of_hour(0, 30) }

  def perform
    Event.where('created_at < ?', 3.days.ago).delete_all
  end
end
