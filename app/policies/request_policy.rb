class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def new?
    record.product.user != user
  end

  def create?
    record.product.user != user
  end

  def edit?
    record.user == user
  end

  def show?
    # record.user == user
    record.product.user == user || record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def accept?
    record.product.user == user && record.status == 'pending'
  end

    def reject?
    record.product.user == user && record.status == 'pending'
  end
end
