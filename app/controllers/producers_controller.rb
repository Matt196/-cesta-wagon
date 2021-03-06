class ProducersController < ApplicationController
  before_action :set_producer, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized, only: [:create, :new]


  def index
    @first_index_impression = cookies["geolocalized"]
    user_location = set_user_location
    results = ProducerFilter.new(params, session).filter(user_location)
    @producers = results[:producers]
    @categories = results[:categories]
    @session = session
    @session[:location] = @session[:location] || 'Lyon'
  end

  def show
    authorize(@producer)
    @product = Product.where(producer: @producer)

    # Initialization reviews
    @producer_review = ProducerReview.new
    @producer_reviews = @producer.producer_reviews.order('created_at ASC')[0..3]
    @basket = BasketLine.new()

    # Build the array of products medals in text format, to be processed by html in view
    @medal = Medal.new(@product).check_medals
  end

  def new
    @producer = Producer.new
  end

  def create
    @producer = Producer.new(producer_params)
    @producer.user = current_user

    if @producer.save
      UserMailer.welcome_email( current_user.email).deliver_now
      redirect_to producers_path
    else
      render :new
    end
  end

  def edit
    authorize(@producer)
  end

  def update
    authorize(@producer)
    @producer.update(producer_params)
    @producer.user = current_user
    redirect_to producers_path
  end

  def destroy
    authorize (@producer)
    @producer.destroy
    flash[:alert] = "Producteur supprimé"
    redirect_to producers_path
  end

  private

  def set_producer
    @producer = Producer.find(params[:id])
  end

  def producer_params
    params.require(:producer).permit(
      :name,
      :address,
      :zipcode,
      :city,
      :description,
      :phone,
      :mobile_phone,
      :company_email,
      :category,
      :avatar,
      photos: [])
  end

  def set_user_location
    if cookies["geolocalized"]
      user_location = session[:location]
    elsif params[:latitude].blank?
      # request.ip == "127.0.0.1" ? ip = "80.214.223.186" : ip = request.ip
      ip = "80.214.223.186"
      user_location = Geocoder.search(ip)[0].data["city"]
    else
      user_location = "#{params[:latitude]},#{params[:longitude]}"
    end
  end

  def params_producer_review
    params.require(:producer_review).permit(
      :content,
      :mark
    )
  end
end
