class Review < ApplicationRecord
  belongs_to :request
  # belongs_to :user
  # has_many :user, through: :request

  validates :content, presence: true
end
