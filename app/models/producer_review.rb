class ProducerReview < ApplicationRecord
  belongs_to :producer
  belongs_to :user

  validates :content, presence: true
  validates :mark, presence: true, inclusion: { in: (1..5) }
  validates :user, presence: true
  validates :producer, presence: true

  # vu avec Kévin, pour le moment, ne pas activer cette règle qui fait planter le site.
  # pour le moment, il ne sait pas pourquoi et n'a toujours pas trouvé pourquoi.
  # validates_uniqueness_of :producer, scope: :user

end
