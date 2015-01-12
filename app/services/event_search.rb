class EventSearch

  ALLOWED_TOPICS = [
    'photos',
    'availabilities',
    'unavailabilities',
    'properties',
    'rates',
    'users'
  ]

  ALLOWED_TYPES = [
    'create',
    'update',
    'delete',
    'noop'
  ]

  def initialize(options = {})
    @order     = options.fetch(:order, [{ t: :desc }])
    @page      = options.fetch(:page, 1)
    @per_page  = options.fetch(:per_page, 200)
    @t         = options.fetch(:t, [])
    @topic     = options.fetch(:topic, [])
    @type      = options.fetch(:type, [])
  end

  def scope
    scope = Event.order(@order)
    scope = scope.between_t(@t.first, @t.last) if valid_t_filter?
    scope = scope.where(topic: @topic)         if valid_topic_filter?
    scope = scope.where(type: @type)           if valid_type_filter?
    scope
  end

  def search
    scope.paginate(page: @page, per_page: @per_page)
  end

  private
  def valid_t_filter?
    return false if @t.empty?
    @t.map! { |t| Time.parse(t).to_i }
  end

  def valid_topic_filter?
    @topic = @topic.select { |topic| ALLOWED_TOPICS.include? topic }
    @topic.any?
  end

  def valid_type_filter?
    @type = @type.select { |type| ALLOWED_TYPES.include? type }
    @type.any?
  end
end
