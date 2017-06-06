class OrdersController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def validate_basket_per_producer
    @user =  current_user
    @producer = Producer.find(params[:producer].to_i)
    @basket = BasketLine.all.select do |basketline|
      @producer.products.each do |product|
        basketline.product == product
      end
    end
    if @basket.present?
      BasketLineMailer.send_basket_email(@producer, @basket, @user).deliver_now
      @basket.each do |basketline|
        basketline.destroy
      end
      redirect_to producer_path(@producer)
    else
      flash[:alert] = "Votre panier est vide"
      redirect_to producer_path(@producer)
    end
  end
end
