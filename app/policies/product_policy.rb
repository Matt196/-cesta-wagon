class ProductPolicy < ApplicationPolicy

  def index?
  end

  def show?
    # user == record.producer.user || user.admin?
    true
  end

  def new?
    user == record.user || user.admin?
  end

  def create?
    new?
  end

  def edit?
    user == record.producer.user || user.admin?
  end

  def update?
    edit?
  end

  def destroy?
    user == record.producer.user || user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
