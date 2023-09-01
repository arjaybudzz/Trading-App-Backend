class StockComputingApi

  def self.buy_profit(ticker, transaction, trader)
    profit = format('%.2f', ticker.share.to_f * (ticker.latest_price - ticker.last_price).to_f)

    percent = format('%.2f', profit.to_f / (ticker.share * ticker.last_price.to_f))

    transaction.update(profit: profit.to_f, percent: percent.to_f)
    trader.update_attribute(:balance, trader.balance + transaction.profit.to_f)
  end

  def self.sell_profit(ticker, transaction, trader)
    profit = format('%.2f', -1 * ticker.share * (ticker.latest_price - ticker.last_price).to_f)

    percent = format('%.2f', profit.to_f / (ticker.share * ticker.last_price.to_f))

    transaction.update(profit: profit.to_f, percent: percent.to_f)
    trader.update_attribute(:balance, trader.balance + transaction.profit.to_f)
  end
end
