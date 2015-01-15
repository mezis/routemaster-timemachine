class Replay

  def initialize(scope)
    @scope   = scope
    @clients = {}
  end

  def replay
    @scope.find_each { |event| send_event(event) }
  end

  private

  def send_event(event)
    event_type = case event.type.to_s
                 when 'create' then 'created'
                 when 'update' then 'updated'
                 when 'delete' then 'deleted'
                 when 'noop'   then 'noop'
                 end

    topic = event.topic.pluralize
    uuid  = publisher(topic)

    client_as_uuid(uuid).public_send(event_type, topic, event.url, (event.t * 1000).to_f)
  end

  def client
    @client ||= Routemaster::Client.new(
      url:  ENV['ROUTEMASTER_URL'],
      uuid: ENV['ROUTEMASTER_CLIENT_UUID'],
      timeout: 1
    )
  end

  def client_as_uuid(uuid)
    @clients[uuid] ||= Routemaster::Client.new(
      url:  ENV['ROUTEMASTER_URL'],
      uuid: uuid,
      timeout: 1
    )
  end

  def publisher(topic_name)
    topics.find { |topic| topic[:name] == topic_name }[:publisher]
  end

  def topics
    @topics ||= client.monitor_topics.map(&:attributes)
  end

end
