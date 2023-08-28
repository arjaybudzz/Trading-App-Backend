class AdminSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :first_name, :last_name, :email
  has_many :traders
end
