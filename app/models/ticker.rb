class Ticker < ApplicationRecord
  belongs_to :trader
  has_many :transactions, dependent: :destroy
  validates :symbol, presence: true
  validates :last_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :time_stamp, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :volume, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :share, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
