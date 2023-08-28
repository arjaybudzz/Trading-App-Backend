class AddDefaultValueToTraderBalance < ActiveRecord::Migration[7.0]
  def change
    change_column_default :traders, :balance, from: nil, to: 10_000.00
  end
end
