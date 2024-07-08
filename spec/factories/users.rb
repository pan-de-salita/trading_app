FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@mail.com" }
    sequence(:confirmation_token) { |n| "MyString#{n}" }
    sequence(:reset_password_token) { |n| "MyString#{n}" }

    password { 'foobar' }
    password_confirmation { 'foobar' }
    reset_password_sent_at { '2024-07-08 22:43:36' }
    remember_created_at { '2024-07-08 22:43:36' }
    confirmed_at { '2024-07-08 22:43:36' }
    confirmation_sent_at { '2024-07-08 22:43:36' }
    unconfirmed_email { 'MyString' }
    admin_created { false }
  end
end
