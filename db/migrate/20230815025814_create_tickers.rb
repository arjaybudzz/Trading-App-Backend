class CreateTickers < ActiveRecord::Migration[7.0]
  def change
    create_table :tickers do |t|
      t.string :symbol
      t.decimal :last_price
      t.integer :time_stamp
      t.decimal :volume
      t.belongs_to :trader, null: false, foreign_key: true

      t.timestamps
    end
  end
end
