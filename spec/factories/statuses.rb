# == Schema Information
#
# Table name: statuses
#
#  id          :bigint           not null, primary key
#  status_type :enum             default("pending"), not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :status do
    trait :without_user do
      user_id { nil }
    end

    trait :with_user do
      user_id { create(:user, email: 'user@test.com').id }
    end
  end
end
