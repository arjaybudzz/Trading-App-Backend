require 'rails_helper'

RSpec.describe Trader, type: :model do
  describe 'belongs to validation' do
    it { should belong_to(:admin) }
  end

  describe 'ticker association validation' do
    it { should have_many(:tickers).dependent(:destroy) }
  end

  describe 'country validation' do
    it { should validate_presence_of(:country) }
  end

  describe 'account balance validations' do
    it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
  end
end
