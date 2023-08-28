require 'rails_helper'

RSpec.describe Ticker, type: :model do
  describe 'trader association test' do
    it { should belong_to(:trader) }
  end

  describe 'transactions association test' do
    it { should have_many(:transactions).dependent(:destroy) }
  end

  describe 'symbol validation' do
    it { should validate_presence_of(:symbol) }
  end

  describe 'last price validitation' do
    it { should validate_presence_of(:last_price) }
    it { should validate_numericality_of(:last_price).is_greater_than_or_equal_to(0) }
  end

  describe 'timestamp validation' do
    it { should validate_presence_of(:time_stamp) }
    it { should validate_numericality_of(:time_stamp).is_greater_than_or_equal_to(0) }
  end

  describe 'volume validation' do
    it { should validate_presence_of(:volume) }
    it { should validate_numericality_of(:volume) }
  end

  describe 'share attribute validatons' do
    it { should validate_presence_of(:share) }
    it { should validate_numericality_of(:share).is_greater_than_or_equal_to(1) }
  end
end
