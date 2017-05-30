class Producer < ApplicationRecord
  #Tables relations
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :producer_awards, dependent: :destroy

  #Geocoder
  geocoded_by :address
  after_validation :geocode

  #Rows validations
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :zipcode, presence: true
  validates :city, presence: true
  validates :description, presence: true
  validates :phone, presence: true, unless: ->(producer){producer.mobile_phone.present?}
  validates :mobile_phone, presence: true, unless: ->(producer){producer.phone.present?}
  validates :company_email, presence: true, uniqueness: true
  validates :category, presence: true
  validates :user, presence: true
end
