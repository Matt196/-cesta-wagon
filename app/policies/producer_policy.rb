class ProducerPolicy < ApplicationPolicy

  def form_acces?
    user.is_a?(User) &&
    user.producer.present? ? record.id != user.producer.id : true &&
    validate_uniqueness_review if user.is_a?(User)
  end

  def edit?
    user.is_a?(User) &&
    record.id == user.producer.id if user.producer.present?
  end

  def update?
    edit?
  end

  def destroy?
    user == record.user || user.admin?
  end

  def validate_uniqueness_review
    if record.producer_reviews.present?
      tt = record.producer_reviews.map do |elem|
        elem.user_id
      end
      !tt.uniq.include?(user.id)
    else
      true
    end
  end

class Scope < Scope
    def resolve
      scope.all
    end
  end

end
