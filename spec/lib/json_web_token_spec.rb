require 'rails_helper'

RSpec.describe JsonWebToken do
  setup do
    @admin_sample = create(:admin)
    @trader_sample = create(:trader)
    @ticker_sample = create(:ticker)
  end

  describe 'decoded admin token should match admin id' do
    before { @admin_token = JsonWebToken.encode(admin_id: @admin_sample.id) }
    it { expect(JsonWebToken.decode(@admin_token)[:admin_id]).to match(@admin_sample.id) }
  end

  describe 'decoded trader token should match admin id' do
    before { @trader_token = JsonWebToken.encode(trader_id: @trader_sample.id) }
    it { expect(JsonWebToken.decode(@trader_token)[:trader_id]).to eq(@trader_sample.id) }
  end

  describe 'decoded ticker token should match ticker id' do
    before { @ticker_token = JsonWebToken.encode(ticker_id: @ticker_sample.id) }
    it { expect(JsonWebToken.decode(@ticker_token)[:ticker_id]).to eq(@ticker_sample.id) }
  end
end
