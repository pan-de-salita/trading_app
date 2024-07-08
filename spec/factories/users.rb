FactoryBot.define do
  factory :user do
    email { 'MyString' }
    encrypted_password { 'MyString' }
    reset_password_token { 'MyString' }
    reset_password_sent_at { '2024-07-08 22:43:36' }
    remember_created_at { '2024-07-08 22:43:36' }
    role { '' }
    confirmation_token { 'MyString' }
    confirmed_at { '2024-07-08 22:43:36' }
    confirmation_sent_at { '2024-07-08 22:43:36' }
    unconfirmed_email { 'MyString' }
    admin_created { false }
  end
end
