class AddLastPriceToTicker < ActiveRecord::Migration[7.0]
  def change
    add_column :tickers, :latest_price, :decimal
  end
end
