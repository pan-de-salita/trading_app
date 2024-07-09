FactoryBot.define do
  factory :transaction do
    amount { "9.99" }
    share_price { "9.99" }
    share_qty { "9.99" }
    transaction_type { "" }
    user { nil }
    stock { nil }
  end
end
