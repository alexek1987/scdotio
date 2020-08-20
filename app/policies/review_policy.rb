class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.request.product.user == user && Request.find(record.request.id).review.nil? && record.request.status == "completed"
  end

end
