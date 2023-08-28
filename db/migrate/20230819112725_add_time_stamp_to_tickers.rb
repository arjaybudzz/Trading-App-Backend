class AddTimeStampToTickers < ActiveRecord::Migration[7.0]
  def change
    add_column :tickers, :time_stamp, :string
  end
end
