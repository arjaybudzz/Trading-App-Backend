class AddActionAttributeToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :action, :string
  end
end
