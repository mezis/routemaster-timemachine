class Replay

  def initialize(scope)
    @scope = scope
  end

  def replay
    @scope.find_each { |event| send_event(event) }
  end

  private

  def send_event(event)
    routemaster_event_type = case event.type.to_s
                             when 'create' then 'created'
                             when 'update' then 'updated'
                             when 'delete' then 'deleted'
                             when 'noop'   then 'noop'
                             end

    client.public_send(routemaster_event_type, event.topic.pluralize, event.url, (event.t * 1000).to_f)
  end

  def client
    @routemaster_client ||= Routemaster::Client.new(
      url:  ENV['ROUTEMASTER_URL'],
      uuid: ENV['ROUTEMASTER_CLIENT_UUID'],
      timeout: 1
    )
  end

end
