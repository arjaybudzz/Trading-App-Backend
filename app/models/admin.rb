class Admin < ApplicationRecord
  include CommonDataValidation

  has_many :traders, dependent: :destroy
end
