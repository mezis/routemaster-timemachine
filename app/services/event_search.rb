class EventSearch

  def initialize(options = {})
    @order     = options.fetch(:order, [{ t: :desc }])
    @page      = options.fetch(:page, 1)
    @per_page  = options.fetch(:per_page, 200)
  end

  def search
    Event.order(@order).paginate(page: @page, per_page: @per_page)
  end
end
