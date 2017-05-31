class ProductPolicy < ApplicationPolicy

  def new?
    record.producer == user.producer || user.admin?
  end

  def create?
    new?
  end

  def edit?
    record.producer == user.producer || user.admin?
  end

  def update?
    edit?
  end

  def destroy?
    record.producer == user.producer || user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
