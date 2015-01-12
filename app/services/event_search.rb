class EventSearch

  def initialize(options = {})
    @order     = options.fetch(:order, [{ t: :desc }])
    @page      = options.fetch(:page, 1)
    @per_page  = options.fetch(:per_page, 200)
    @t         = options.fetch(:t, [])
  end

  def scope
    scope = Event.order(@order)
    scope = scope.between_t(@t.first, @t.last) if valid_t_filter?
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
end
