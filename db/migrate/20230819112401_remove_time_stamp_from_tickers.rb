class RemoveTimeStampFromTickers < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickers, :time_stamp
  end
end
