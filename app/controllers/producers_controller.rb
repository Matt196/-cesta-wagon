class ProducersController < ApplicationController
  before_action :set_producer, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized, only: [:create, :new]

  def index
    store_session
    results = ProducerFilter.new(params).filter
    @producers = results[:producers]
    @categories = results[:categories]

    # Pseudo code for filter & sorter features
    # Sort list of products by user query
      # Input = list of products
      # Output = sorted list of product


# CODE DE GUILLAUME A REACTIVER APRES AJOUT DES FILTRES
    # if params[:latitude].blank? & (params[:location].blank? || params[:location] == "null")
    #   request.ip == "127.0.0.1" ? ip = "80.214.144.229" : ip = request.ip
    #   @producers = Producer.near(ip, 1000).limit(10)
    #   session[:location] = Geocoder.search(ip)[0].data["city"]
    # elsif params[:latitude].blank?
    #   @producers = Producer.near(params[:location], 1000).limit(10)
    #   session[:location] = params[:location]
    # else
    #   @producers = Producer.near("#{params[:latitude]}, #{params[:longitude]}", 1000).limit(10)
    #   session[:latitude] = params[:latitude]
    #   session[:longitude] = params[:longitude]
    #   # Geocoder : by default, objects are ordered by distance.
    # end
# CODE DE GUILLAUME A REACTIVER APRES AJOUT DES FILTRS


    # @hash = Gmaps4rails.build_markers(@producers) do |producer, marker|
    #   marker.lat producer.latitude
    #   marker.lng producer.longitude
    # end
  end

  def show
    authorize(@producer)
    @product = Product.where(producer: @producer)

    # Initialization reviews
    @producer_review = ProducerReview.new
    @producer_reviews = @producer.producer_reviews.sort_by {|elem| elem.create_user}[0..3]

    @basket = BasketLine.new()

    # Build the array of products medals in text format, to be processed by html in view
    @medal = check_medals(@product)
  end

  #-- METHODES NEW ET CREATE POUR FACILITER LE DEBUGG, A SUPPRIMER QUAND MODEL PRODUCER TERMINE --#
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
  #-- FIN : METHODES NEW ET CREATE POUR FACILITER LE DEBUGG, A SUPPRIMER QUAND MODEL PRODUCER TERMINE --#
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
    flash[:alert] = "Producteur supprimé de la bdd"
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

  def params_producer_review
    params.require(:producer_review).permit(
      :content,
      :mark
    )
  end

  def store_session
    if session[:location].present?
      @location = session[:location]
    elsif params[:location].present?
      @location = params[:location]
    end
  end

  def check_medals(products)
    #This method needs the medal files names in assets/images to remain unchanged
    medal =[]
    products.each do |product|
      if product.product_awards.present?
        if product.product_awards.name.include? "gold"
          image = "gold_medal.png"
          hidden = ""
        elsif product.product_awards.name.include? "silver"
          award = "silver_medal.png"
          hidden = ""
        else
          award = "bronze_medal.png"
          hidden = ""
        end
      else
        award = "no-medal.png"
        hidden = "hidden"
      end
      medal << [award, hidden]
    end
    medal
  end
end
