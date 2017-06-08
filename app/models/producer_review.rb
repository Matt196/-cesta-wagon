class ProducerReview < ApplicationRecord
  belongs_to :producer
  belongs_to :user

  validates :content, presence: true
  validates :mark, presence: true, inclusion: { in: (1..5) }
  validates :user, presence: true
  validates :producer, presence: true
  validates_uniqueness_of :producer, {scope: :user,

    message: "vous avez déjà laissé un commentaire" }



end
