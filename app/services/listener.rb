class Listener

  def on_events_received(batch)
    batch.each do |event|
      Event.create!(
        topic: event.topic,
        type: event.type,
        url: event.url,
        t: event.t / 1000)
    end
  end

end
