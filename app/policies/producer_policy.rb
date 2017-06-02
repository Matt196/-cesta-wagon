class ProducerPolicy < ApplicationPolicy

  def edit?
    user.is_a?(User)
    # true
    # user == record.user || user.admin? || user.class == Gest
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
