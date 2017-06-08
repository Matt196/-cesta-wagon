class BasketLine < ApplicationRecord
  belongs_to :user
  belongs_to :product # through: :producer_id


  validates :product_id, uniqueness: { scope: :user_id,
    message: "this product is already in your basket" }



end
