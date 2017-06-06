class BasketLinesController < ApplicationController

  skip_after_action :verify_authorized, only: [:new, :create]
  before_action :params_basket, only: :qte
  before_action :id_basket, only: [:destroy, :update]


# Il faudra activer pundit dans un second temps

  def index
    @basket = BasketLine.where(user_id: current_user.id)
    authorize(@basket)
    @basket = @basket.sort_by { |elem| elem.product.producer.name }
    @producers = @basket.uniq{|elem| elem.product.producer.name}
  end

  def create
    @basket = BasketLine.new(params_basket)
    @basket.user_id = current_user.id
    @basket.save
  end

  def update
    authorize(@basket)
    @basket.update(params_basket)
  end

  def destroy
    authorize(@basket)
    @basket.destroy
  end

  private
    def params_basket
      params.require(:basket_line).permit(:qte, :product_id, :id)
    end

    def id_basket
      @basket = BasketLine.find(params[:id])
    end
end


