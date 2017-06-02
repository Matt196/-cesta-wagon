class ProducerReviewsController < ApplicationController
  before_action :id_producer_review, only: [:show, :edit, :update, :destroy]
  before_action :id_producer, only: [:new, :create]
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized, only: [:create, :new]

  def show
  end

  def create
    # @product = Product.where(producer_id: @producer)
    @producer_review = ProducerReview.new(params_producer_review)
    @producer_review.producer = @producer
    @producer_review.user = current_user
    @producer_review.save
  end

  def edit
    authorize (@producer_review)
  end

  def update
    authorize (@producer_review)
    @producer_review.update(params_producer_review)

  end

  def destroy
    authorize (@producer_review)
    @producer_review.destroy
  end

  private
    def id_producer_review
      @producer_review = ProducerReview.find(params[:id])
    end

    def id_producer
      @producer = Producer.find(params[:producer_id])
    end

    def params_producer_review
      params.require(:producer_review).permit(
        :content,
        :mark
        )
    end
end
