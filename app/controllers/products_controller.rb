class ProductsController < ApplicationController
  before_action :producer_id, only: [:new, :create]
  before_action :product_id, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.where(producer_id:@producer)
    authorize (@product)

  end

  def show
    authorize (@product)

  end

  def new
    @product = Product.new()
    authorize (@producer)
  end

  def create
    @product = Product.new(params_product)
    @product.producer = @producer
    authorize (@producer)

    if @product.save
      redirect_to producer_path(@producer), notice: "thanks to your new product"
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
    redirect_to producer_path(@producer)
  end

  def destroy
    @producer = @product.producer
    authorize (@product)
    @product.destroy
    redirect_to producer_path(@producer)
  end


  private
    def product_id
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

    def producer_id
      @producer = Producer.find(params[:producer_id])
    end
end



