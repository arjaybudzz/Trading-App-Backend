class TraderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :first_name, :last_name, :email, :country, :approved, :balance
  belongs_to :admin
  has_many :tickers
end
