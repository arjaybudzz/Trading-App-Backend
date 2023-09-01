FactoryBot.define do
  factory :trader do
    username { Faker::Internet.unique.username }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    country { Faker::Address.country }
    password { Faker::Internet.password(min_length: 8, max_length: 20) }
    password_confirmation { password }
    balance { 10_000.00 }
    approved { false }
    admin { association :admin }

    trait :approved do
      approved { true }
    end

    trait :empty_username do
      username { nil }
    end

    factory :trader_approved, traits: [:approved]
    factory :invalid_username, traits: [:empty_username]
  end
end
