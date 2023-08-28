class RemoveAdminForeignKeyFromTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :transactions, :admin
  end
end
