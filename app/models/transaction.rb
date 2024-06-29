class Transaction < ApplicationRecord
  belongs_to :stock, optional: true
  belongs_to :user

  validates :share_qty, numericality: { greater_than_or_equal_to: 1 }

  enum :transaction_type, {
  deposit: "deposit",
  withdraw: "withdraw",
  buy: "buy",
  sell: "sell"
  }
end
