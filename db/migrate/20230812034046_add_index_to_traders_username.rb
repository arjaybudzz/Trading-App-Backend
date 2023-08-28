class AddIndexToTradersUsername < ActiveRecord::Migration[7.0]
  def change
    add_index :traders, :username, unique: true
  end
end
