class Product < ApplicationRecord
  belongs_to :producer
  has_many :product_awards, dependent: :destroy
  has_many :basket_lines, dependent: :destroy

  has_attachments :photos, maximum: 3


  validates :price, presence: true, numericality: { greater_than_or_equal: 0 }
  validates :name, presence: true
  validates :description, presence: true
  validates :producer, presence: true
end
