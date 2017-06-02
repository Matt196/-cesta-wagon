class ProducerPolicy < ApplicationPolicy

  def edit?
    user == record.user || user.admin? || user if user.present?
  end

  def update?
    edit?
  end

  def destroy?
    user == record.user || user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
