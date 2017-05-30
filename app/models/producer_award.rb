class ProducerAward < ApplicationRecord
  belongs_to :producer

  validates :name, presence: true, uniqueness: true
  # validates :producer, presence: true
end
