class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :request

  validates :user, presence: true

  def sender
    user
  end

  def recipient
    if request.product.user == user
        request.user
    else
        request.product.user
    end
  end
end
