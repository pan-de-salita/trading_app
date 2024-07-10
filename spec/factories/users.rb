# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :enum             default("trader"), not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  admin_created          :boolean          default(FALSE)
#
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
