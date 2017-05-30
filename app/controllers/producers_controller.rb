class ProducersController < ApplicationController
before_action :set_producer, only: [:show]

  def index
    # 1 récupérer la localisation de l'utilisateur

    # 2 afficher la liste des producteurs du coin
    @producers = Producer.where.not(latitude: nil, longitude: nil)
    # A remplacer par Producer.near("{#current_user.latitude} {#current_user.longitude}")

    @hash = Gmaps4rails.build_markers(@producers) do |producer, marker|
      marker.lat producer.latitude
      marker.lng producer.longitude
    end
  end

  def show
    @producer = Producer.find(params[:id])
    authorize (@producer)
  end

  #-- METHODES NEW ET CREATE POUR FACILITER LE DEBUGG, A SUPPRIMER QUAND MODEL PRODUCER TERMINE --#
  def new
    @producer = Producer.new
    authorize (@producer)
  end

  def create
    @producer = Producer.new(producer_params)
    authorize (@producer)

    @producer.user = User.find(1)
    if @producer.save
      redirect_to producers_path
    else
      render :new
    end
  end
  #-- FIN : METHODES NEW ET CREATE POUR FACILITER LE DEBUGG, A SUPPRIMER QUAND MODEL PRODUCER TERMINE --#

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
      :category)
  end
end
