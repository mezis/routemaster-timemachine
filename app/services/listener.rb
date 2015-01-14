class Listener

  def on_events_received(batch)
    batch.each do |event|

      Event.where({
        topic: event.topic,
        type:  event.type,
        url:   event.url,
        t:     event.t / 1000
      }).first_or_create

    end
  end

end
