class ProducerPolicy < ApplicationPolicy

  def edit?
    record == user.producer
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
