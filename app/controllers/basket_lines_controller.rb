class BasketLinesController < ApplicationController

  # before_action :id_producer_review, only: [:show, :edit, :update, :destroy]
  # before_action :id_producer, only: [:new, :create]
  # skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized, only: [:create, :show]

# Il faudra activer pundit dans un second temps

  def show
  end

  def create
    @basket.create(
      user: current_user,
      product: Product.find(params[:product_id])
    )
  end
end
