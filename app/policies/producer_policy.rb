class ProducerPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    user == record.user || user.admin? if user.present?
  end

  def update?
    edit?
  end

  def destroy?
    user == record.user || user.admin? if user.present?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
