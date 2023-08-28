class AddTraderReferenceToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :trader, foreign_key: true
  end
end
