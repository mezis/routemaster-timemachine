class Listener

  def on_events_received(batch)
    batch.each do |event|
      puts event
    end
  end

end
