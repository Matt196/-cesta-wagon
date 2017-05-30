class ProducerPolicy < ApplicationPolicy

  def initialize(user, record)
  end

  def index?
  end

  def show?
  end

  def new?
    true
    # user == record.user || user.admin?
  end

  def create?
    new?
  end

  def edit?
    true
    # user == record.user || user.admin?
  end

  def update?
    edit?
  end

  def destroy?
    true
    # user == record.user || user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
