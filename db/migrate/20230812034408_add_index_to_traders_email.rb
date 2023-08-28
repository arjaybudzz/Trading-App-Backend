class AddIndexToTradersEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :traders, :email, unique: true
    change_column_default :traders, :approved, from: nil, to: false
  end
end
