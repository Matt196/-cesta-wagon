class ProducerPolicy < ApplicationPolicy


  def index?
  end

  def show?
  end

  def new?
    user == record.user || user.admin?
  end

  def create?
    new?
  end

  def edit?
    user == record.user || user.admin?
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