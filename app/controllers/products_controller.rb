class ProductsController < ApplicationController
  before_action :producer_id, only: [:index, :new, :create, :destroy]
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.where(producer_id:@producer)
  end

  def show
    @product = Product.where(id:@product)
  end

  def new
    @product = Product.new()
  end

  def create
    @product = Product.new(params_product)
    @product.producer = @producer

    if @product.save
      redirect_to producer_path(@producer), thanks to your new product
    else
      render :new
    end
  end

  def edit
  end

  def update
    @product.update(params_product)
    redirect_to product_path(@product)
  end

  def destroy
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



