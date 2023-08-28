class StockComputingApi
  def self.reduce_trader_balance(trader, ticker)
    trader.update_attribute(:balance, trader.balance - (ticker.share * ticker.last_price))
  end

  def self.buy_profit(ticker)
    ticker.share * (ticker.latest_price - ticker.last_price)
  end

  def self.sell_profit(ticker)
    ticker.share * (ticker.last_price - ticker.latest_price)
  end

  def self.compute_percent(ticker)
    format('%.2f', ((ticker.latest_price.to_f - ticker.last_price.to_f) / ticker.last_price.to_f) * 100)
  end
end
