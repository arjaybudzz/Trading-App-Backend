FactoryBot.define do
  factory :admin do
    username { Faker::Internet.unique.username }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { password }

    trait :invalid do
      email { nil }
    end

    factory :empty_email, traits: [:invalid]
  end
end
