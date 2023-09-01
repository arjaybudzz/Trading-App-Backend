require 'rails_helper'

RSpec.describe StockComputingApi do
  setup do
    @trader_sample = create(:trader)
    @ticker_sample = create(:ticker)
    @transaction_sample = create(:transaction)
  end

  context 'trader buys a stock' do
    before do
      StockComputingApi.buy_profit(@ticker_sample, @transaction_sample, @trader_sample)
    end

    it { expect(@trader_sample.balance).to eq(9_000) }
    it { expect(@transaction_sample.profit).to eq(-1_000) }
    it { expect(@transaction_sample.percent).to eq(-0.2) }
  end

  context 'trader sells a stock' do
    before do
      StockComputingApi.sell_profit(@ticker_sample, @transaction_sample, @trader_sample)
    end

    it { expect(@trader_sample.balance).to eq(11_000) }
    it { expect(@transaction_sample.profit).to eq(1_000) }
    it { expect(@transaction_sample.percent).to eq(0.2) }
  end
end
