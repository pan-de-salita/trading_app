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
