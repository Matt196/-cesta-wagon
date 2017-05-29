class Product < ApplicationRecord
  belongs_to :producer
  has_many :product_awards, dependent: :destroy
  has_many :producer_reviews, dependent: :destroy

  validates :price, presence: true, numericality: { greater_than_or_equal: 0 }
  validates :name, presence: true
  validates :description, presence: true
  validates :producer, presence: true
end
