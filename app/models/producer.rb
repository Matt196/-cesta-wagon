class Producer < ApplicationRecord
# belongs_to :user
has_many :products, dependent: :destroy
has_many :producer_awards

# validates :name, presence: true
# validates :address, presence: true
# validates :zipcode, presence: true
# validates :city, presence: true
# validates :description, presence: true
# validates :phone, presence: true, unless: ->(producer){producer.mobile_phone.present?}
# validates :mobile_phone, presence: true, unless: ->(producer){producer.phone.present?}
# validates :company_email, presence: true
# validates :category, presence: true
end
