class RemoveTraderReferenceToTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :transactions, :trader
  end
end
