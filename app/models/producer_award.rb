class ProducerAward < ApplicationRecord
  belongs_to :producer

  validates :name, presence: true
  # validates :producer, presence: true
end
