class BasketLinesController < ApplicationController

  # before_action :id_producer_review, only: [:show, :edit, :update, :destroy]
  # before_action :id_producer, only: [:new, :create]
  # skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized, only: [:new, :show]

# Il faudra activer pundit dans un second temps

  def new

    @basket = BasketLine.new(
      user_id: current_user.id,
      product_id: params["format"]
      )
    @basket.save
    binding.pry
    redirect_to producer_path(@basket.product.producer.id)



  end

  def create

 @basket = BasketLine.new(
      user_id: current_user.id,
      product_id: params["format"]
      )
    @basket.save
    binding.pry
    redirect_to producer_path(@basket.product.producer.id)
  end




  def show
    @basket = BasketLine.where(user_id: current_user.id)
    @basket = @basket.sort_by { |elem| elem.product.producer.name }
    @producers = @basket.uniq{|elem| elem.product.producer.name}
  end

  def destroy
    @basket = BasketLine.find(params[:id])

    @basket.product.destroy

    redirect_to basket_lines_path
  end

  private





end


