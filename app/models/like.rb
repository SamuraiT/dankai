class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :ordered, -> { order(created_at: :desc) }
end
