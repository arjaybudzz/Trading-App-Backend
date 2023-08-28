require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'association test' do
    it { should belong_to(:ticker) }
  end

  describe 'stock validations' do
    it { should validate_presence_of(:stock) }
  end

  describe 'profit validations' do
    it { should validate_presence_of(:profit) }
  end

  describe 'percent validations' do
    it { should validate_presence_of(:percent) }
    it { should validate_numericality_of(:percent).is_greater_than_or_equal_to(-100).is_less_than_or_equal_to(100) }
  end

  describe 'action validation' do
    it { should validate_presence_of(:action) }
  end
end
