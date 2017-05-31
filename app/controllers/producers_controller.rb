class ProducersController < ApplicationController
  before_action :set_producer, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized, only: [:create, :new]

  def index
    #rajouter si besoin centrage de la carte sur une position initiale avant les requetes via javascript. defaut = monde
    if params[:latitude].blank? & params[:longitude].blank?
      # session[:location] = params[:location]
      @producers = Producer.near(params[:location], 1000).limit(10)
    else
      # session[:latitude] = params[:latitude]
      # session[:longitude] = params[:longitude]
      @producers = Producer.near("#{params[:latitude]}, #{params[:longitude]}", 1000).limit(10)
      # Geocoder : by default, objects are ordered by distance.
    end

    @hash = Gmaps4rails.build_markers(@producers) do |producer, marker|
      marker.lat producer.latitude
      marker.lng producer.longitude
    end
  end

  def show
    authorize (@producer)
    @product = Product.where(producer_id:@producer)
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
    flash[:alert] = "Producteur supprimer de la bdd"
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
      photos: [])
  end
end
