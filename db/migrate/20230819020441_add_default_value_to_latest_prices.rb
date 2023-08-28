class AddDefaultValueToLatestPrices < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tickers, :latest_price, from: nil, to: 0
  end
end
