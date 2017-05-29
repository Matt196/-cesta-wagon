class ProductAward < ApplicationRecord
  belongs_to :product

  validates :name, presence: true
  validates :product, presence: true
end
