class Sweeper < ActiveJob::Base
  queue_as :default

  def perform
    Event.where('created_at < ?', 5.days.ago).delete_all
  end
end
