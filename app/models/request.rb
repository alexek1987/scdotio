class Request < ApplicationRecord
  STATUS = ['accepted', 'rejected', 'pending', 'completed']
  validates :content, presence: true
  validates :status, inclusion: { in: STATUS }

  belongs_to :product
  belongs_to :user

  has_one :review
  has_many :entries

  def request_icon
    case self.status
    when "accepted"
      return "fas fa-paw text-primary"
    when "rejected"
      return "fa fa-times-circle text-danger"
    when "pending"
      return "fa fa-circle text-info"
    when "completed"
      return "fa fa-check-circle text-success"
    end
  end

end
