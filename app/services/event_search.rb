class EventSearch

  def initialize(options = {})
    @order = options.fetch(:order, [{ t: :desc }])
  end

  def search
    Event.order(@order)
  end
end
