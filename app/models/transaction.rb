class Transaction < ApplicationRecord
  belongs_to :stock, optional: true
  belongs_to :user

  enum :transaction_type, {
  deposit: "deposit",
  withdraw: "withdraw",
  buy: "buy",
  sell: "sell"
  }
end
