class MonitorController < ActionController::Base

  def health
    health = Event.where(created_at: monitor_window).count >= monitor_threshold
    render layout: false, text: health
  end

  private

  def monitor_window
    ENV.fetch('MONITOR_EVENTS_WINDOW', 120).to_i.minutes.ago..Time.now
  end

  def monitor_threshold
    ENV.fetch('MONITOR_EVENTS_THRESHOLD', 50).to_i
  end

end
