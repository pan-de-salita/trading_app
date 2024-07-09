FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@mail.com" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
