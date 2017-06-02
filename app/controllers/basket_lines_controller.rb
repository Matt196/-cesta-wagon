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
  end

  def show
    @basket = BasketLine.where(user_id: current_user.id)
  end
end
