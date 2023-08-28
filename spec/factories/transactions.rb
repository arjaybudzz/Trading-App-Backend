FactoryBot.define do
  factory :transaction do
    stock { "MyString" }
    profit { "9.99" }
    percent { "9.99" }
    action { "buy" }
    ticker { association :ticker }
  end
end
