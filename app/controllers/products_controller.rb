class ProductsController < ApplicationController
  before_action :set_producer_id, only: [:new, :create]
  before_action :set_product_id, only: [:show, :edit, :update, :destroy]

  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized, only: [:index, :show]


  def index
    @products = Product.where(producer_id:@producer)

  end

  def show

  end

  def new
    @product = Product.new()
    authorize (@product)
  end

  def create
    @product = Product.new(params_product)
    @product.producer = @producer
    authorize (@product)

    if @product.save
      redirect_to profile_path, notice: "thanks to your new product"
    else
      render :new
    end
  end

  def edit
    authorize (@product)
  end

  def update
    @producer = @product.producer
    authorize (@product)
    @product.update(params_product)
    redirect_to profile_path
  end

  def destroy
    @producer = @product.producer
    authorize (@product)
    @product.destroy
  end

  private
    def set_product_id
      @product = Product.find(params[:id])
    end

    def params_product
      params.require(:product).permit(
        :name,
        :description,
        :price,
        photos: []
      )
    end

    def set_producer_id
      @producer = Producer.find(params[:producer_id])
    end
end



