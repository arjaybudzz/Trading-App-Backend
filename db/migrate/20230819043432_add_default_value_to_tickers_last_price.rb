class AddDefaultValueToTickersLastPrice < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tickers, :last_price, from: nil, to: 0
  end
end
