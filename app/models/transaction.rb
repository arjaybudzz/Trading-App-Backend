class Transaction < ApplicationRecord
  belongs_to :ticker

  validates :stock, presence: true
  validates :profit, presence: true
  validates :action, presence: true
  validates :percent, presence: true, numericality: { less_than_or_equal_to: 100, greater_than_or_equal_to: -100 }
end
