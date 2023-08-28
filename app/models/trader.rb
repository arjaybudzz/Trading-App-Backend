class Trader < ApplicationRecord
  include CommonDataValidation
  belongs_to :admin
  has_many :tickers, dependent: :destroy

  validates :country, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
