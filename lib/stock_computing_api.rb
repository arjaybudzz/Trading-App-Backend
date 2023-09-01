class StockComputingApi
  def self.buy_profit(ticker, transaction, trader)
    profit = (ticker.share.to_f * (ticker.latest_price - ticker.last_price).to_f).round(2)

    percent = (profit.to_f / (ticker.share * ticker.last_price.to_f)).round(2)

    transaction.update(profit:, percent:)
    trader.update_attribute(:balance, trader.balance + transaction.profit)
  end

  def self.sell_profit(ticker, transaction, trader)
    profit = (-1 * ticker.share * (ticker.latest_price - ticker.last_price).to_f).round(2)

    percent = (profit.to_f / (ticker.share * ticker.last_price.to_f)).round(2)

    transaction.update(profit:, percent:)
    trader.update_attribute(:balance, trader.balance + transaction.profit)
  end
end
