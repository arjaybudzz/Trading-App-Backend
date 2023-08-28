class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :stock
      t.decimal :profit
      t.decimal :percent
      t.datetime :date_of_transaction
      t.belongs_to :ticker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
