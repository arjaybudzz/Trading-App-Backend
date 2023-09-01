FactoryBot.define do
  factory :transaction do
    stock { "MyString" }
    profit { 9.99 }
    percent { 9.99 }
    action { 'buy' }
    ticker { association :ticker }

    trait :seller do
      action { 'sell' }
    end

    trait :empty_stock_name do
      stock { nil }
    end
  end
end
