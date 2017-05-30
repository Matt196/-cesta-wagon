class ProductsController < ApplicationController
  before_action :producer_id, only: [:index, :new, :create, :destroy]
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.where(producer_id:@producer)
    authorize (@product)

  end

  def show
    @product = Product.where(id:@product)
    authorize (@product)

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
      redirect_to producer_path(@producer), notice: "thanks to your new product"
    else
      render :new
    end
  end

  def edit
    authorize (@product)
  end

  def update
    authorize (@product)
    @product.update(params_product)
    redirect_to product_path(@product)
  end

  def destroy
    authorize (@product)
    @product.destroy
    redirect_to producer_path(@producer)
  end


  private
    def set_product
      @product = Product.find(params[:id])
    end

    def params_product
      params.require(:product).permit(
        photos: []
      )
    end

    def producer_id
      @producer = Producer.find(params[:producer_id])
    end
end



