# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  amount           :decimal(, )
#  share_price      :decimal(, )
#  share_qty        :decimal(, )
#  transaction_type :enum             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint
#  stock_id         :bigint
#
FactoryBot.define do
  factory :transaction do
    # amount { '9.99' }
    # share_price { '9.99' }
    # share_qty { '9.99' }
    # transaction_type { '' }
    # user { nil }
    # stock { nil }

    trait :buy do
      transaction_type { 'buy' }
    end

    trait :sell do
      transaction_type { 'sell' }
    end
  end
end
