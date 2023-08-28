class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :profit, :percent, :stock, :action
  belongs_to :ticker
end
