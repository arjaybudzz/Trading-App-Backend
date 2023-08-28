FactoryBot.define do
  factory :ticker do
    symbol { 'TESLA' }
    last_price { 5_000.00 }
    latest_price { 4_000.00 }
    time_stamp { 1 }
    volume { 50_000 }
    trader { association :trader }
    share { 1 }
  end
end
