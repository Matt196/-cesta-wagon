class BasketLinePolicy < ApplicationPolicy
  def index?
    # test = record.map do |elem|
    #   elem.user_id == user.id
    # end

    # test.any?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def update?
    user.id == record.user_id
  end

  def destroy?
    user.id == record.user_id
  end
end
