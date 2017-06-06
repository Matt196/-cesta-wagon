class ProducerFilter
  attr_reader :params, :categories

  def initialize(params, session)
    @params = params
    @session = session
  end

  def filter(user_location)
    @producers = Producer.all
    @categories = Producer.distinct.pluck(:category).sort

    filter_by_category if params[:categories].present?
    filter_by_mark if params[:mark].present?
    filter_by_location(user_location)

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

  def filter_by_location(user_location)
    if params[:query_location].present?
      @producers = @producers.near(params[:query_location], 200).limit(10)
      @session[:location] = params[:query_location]
    elsif
      @producers = @producers.near(user_location, 500).limit(10)
      @session[:location] = @session[:location] || user_location
    end
  end
end
