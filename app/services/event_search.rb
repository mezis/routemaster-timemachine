class EventSearch
  include ActiveModel::Model

  ALLOWED_TOPICS = [
    'photos',
    'availabilities',
    'unavailabilities',
    'properties',
    'rates',
    'users_photo'
  ]

  ALLOWED_TYPES = [
    'create',
    'update',
    'delete',
    'noop'
  ]

  attr_reader :t, :topic, :type

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
    scope = scope.between_t(
              Time.parse(@t.first).to_f,
              Time.parse(@t.last).to_f
            ) if valid_t_filter?
    scope = scope.where(topic: @topic) if valid_topic_filter?
    scope = scope.where(type: @type)   if valid_type_filter?
    scope
  end

  def search
    scope.paginate(page: @page, per_page: @per_page)
  end

  private
  def valid_t_filter?
    @t.reject!(&:empty?)

    return false if @t.empty?
    return false if @t.length != 2
    return true
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
