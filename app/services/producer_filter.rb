class ProducerFilter
  attr_reader :params, :categories

  def initialize(params)
    @params = params
  end

  def filter
    @producers = Producer.limit(10)
    @categories = Producer.distinct.pluck(:category).sort

    filter_by_category if params[:categories].present?
    filter_by_mark if params[:mark].present?
    filter_by_location if params[:location].present?

    {
      producers: @producers,
      categories: @categories
    }
  end

  private

  def filter_by_category
    @producers = @producers.where("category in (?)", params[:categories])
  end

  def filter_by_mark
    mark = params[:mark]
    @producers = @producers.joins(:producer_reviews).group(:id).having("avg(producer_reviews.mark) >= ?", mark)
  end

  def filter_by_location
    @producers = @producers.near(params[:location], 200)
  end
end
