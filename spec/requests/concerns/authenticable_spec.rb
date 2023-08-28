require 'rails_helper'

class MockController
  include Authenticable
  attr_accessor :request

  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end

RSpec.describe Authenticable do
  setup do
    @admin_sample = create(:admin)
    @authenticate = MockController.new
  end

  context 'return the admin if authorized' do
    before do
      @authenticate.request.headers['Authorization'] = JsonWebToken.encode(admin_id: @admin_sample.id)
    end

    it { expect(@authenticate.current_admin.id).to match(@admin_sample.id) }
  end

  context 'do not return the admin if unauthorized' do
    before do
      @authenticate.request.headers['Authorization'] = nil
    end

    it { expect(@authenticate.current_admin.nil?).to eq(true) }
  end
end

# Test for trader

RSpec.describe Authenticable do
  setup do
    @trader_sample = create(:trader)
    @authenticate = MockController.new
  end

  context 'return the trader if authorized' do
    before do
      @authenticate.request.headers['Authorization'] = JsonWebToken.encode(trader_id: @trader_sample.id)
    end

    it { expect(@authenticate.current_trader.id).to match(@trader_sample.id) }
  end

  context 'do not return the trader if unauthorized' do
    before { @authenticate.request.headers['Authorization'] = nil }

    it { expect(@authenticate.current_trader.nil?).to eq(true) }
  end
end
