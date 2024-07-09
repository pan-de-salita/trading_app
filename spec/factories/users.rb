FactoryBot.define do
  factory :user do
    password { 'foobar' }
    password_confirmation { 'foobar' }

    trait :trader do
      sequence(:email) { |n| "trader_#{n}@mail.com" }
      role { 'trader' }
    end

    trait :admin do
      email { 'admin@test.com' }
      role { 'admin' }
    end

    trait :confirmed_email do
      confirmed_at { DateTime.now }
    end

    trait :admin_created do
      admin_created { true }
    end
  end
end
