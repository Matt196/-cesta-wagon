class Producer < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :producer_awards, dependent: :destroy
  has_many :producer_reviews, dependent: :destroy

  has_attachment  :avatar
  has_attachments :photos, maximum: 2

  # Geocoder
  geocoded_by :address_concatenated
  after_validation :geocode

  # Rows validations
  validates :name, presence: true
  validates :address, presence: true
  validates :zipcode, presence: true
  validates :city, presence: true
  validates :phone, presence: true, unless: ->(producer){producer.mobile_phone.present?}
  validates :mobile_phone, presence: true, unless: ->(producer){producer.phone.present?}
  validates :company_email, presence: true, uniqueness: true
  validates :category, presence: true

  private

  def address_concatenated
    [address, city].compact.join(', ')
  end

end
