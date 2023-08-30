class StockComputingApi
  def self.reduce_trader_balance(trader, ticker)
    trader.update_attribute(:balance, trader.balance - (ticker.share * ticker.last_price))
  end

  def self.buy_profit(ticker, transaction, trader)
    profit = format('%.2f', ticker.share * (ticker.latest_price - ticker.last_price).to_f)
    percent = format('%.2f', (ticker.latest_price.to_f - ticker.last_price.to_f) / ticker.last_price.to_f)
    transaction.update_attribute(:profit, profit.to_f)
    transaction.update_attribute(:percent, percent.to_f)
    trader.update_attribute(:balance, trader.balance + profit.to_f)
  end

  def self.sell_profit(ticker)
    ticker.share * (ticker.last_price - ticker.latest_price)
  end

  def self.compute_percent(ticker)
    format('%.2f', ((ticker.latest_price.to_f - ticker.last_price.to_f) / ticker.last_price.to_f) * 100)
  end
end
