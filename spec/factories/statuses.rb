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
    status_type { '' }

    trait :without_user do
      user_id { nil }
    end

    trait :with_user do
      user_id { create(:user, :trader).id }
    end
  end
end
