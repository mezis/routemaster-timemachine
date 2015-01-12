class Replay

  def initialize(events)
    @events = Array(events)
  end

  def replay
    @events.each do |event|

      routemaster_event_type = case event.type.to_s
                               when 'create' then 'created'
                               when 'update' then 'updated'
                               when 'delete' then 'deleted'
                               when 'noop'   then 'noop'
                               end

      client.public_send(routemaster_event_type, event.topic.pluralize, event.url, event.t)
    end
  end

  private
  def client
    @routemaster_client ||= Routemaster::Client.new(
      url:  ENV['ROUTEMASTER_URL'],
      uuid: ENV['ROUTEMASTER_CLIENT_UUID'],
      timeout: 1
    )
  end

end
