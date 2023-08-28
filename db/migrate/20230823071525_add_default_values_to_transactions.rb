class AddDefaultValuesToTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column_default :transactions, :profit, from: nil, to: 0
    change_column_default :transactions, :percent, from: nil, to: 0
  end
end
