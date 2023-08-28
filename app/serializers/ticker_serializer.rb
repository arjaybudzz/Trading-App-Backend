class TickerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :symbol, :last_price, :time_stamp, :volume, :latest_price, :share
  belongs_to :trader
  has_many :transactions
end
