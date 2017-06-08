class OrdersController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def validate_basket_per_producer
    @user =  current_user
    @producer = Producer.find(params[:producer].to_i)
    @basket = BasketLine.all.select do |basketline|
      basketline if @producer.id == basketline.product.producer.id
    end
    if @basket.present?
      BasketLineMailer.send_basket_email(@producer, @basket, @user).deliver_now
      @basket.each do |basketline|

        basketline.destroy
      end
      flash[:notice] = "Votre commande est en cour de préparation chez #{@producer.name}"

      redirect_to basket_lines_path
    end
  end
end


