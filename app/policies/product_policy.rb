class ProductPolicy < ApplicationPolicy

  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    user.present?
  end

  def update?
    edit?
  end

  def destroy?
    user.present?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
