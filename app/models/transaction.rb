class Transaction < ApplicationRecord
  belongs_to :stock, optional: true
  belongs_to :user

  validates :share_qty, numericality: { greater_than_or_equal_to: 1 }

  enum :transaction_type, {
    deposit: 'deposit',
    withdraw: 'withdraw',
    buy: 'buy',
    sell: 'sell'
  }

  def calc_gains_or_losses
    share_qty * (share_price - Stock.find(stock.id).price)
  end

  def self.total_shares
    buy_transactions = where(transaction_type: :buy) || 0
    sell_transactions = where(transaction_type: :sell) || 0

    total_shares = buy_transactions.sum('share_qty') - sell_transactions.sum('share_qty')

    total_shares
  end

  def self.avg_price
    transactions = where(transaction_type: :buy) || 0
    total_cost = transactions.sum('share_qty * share_price')
    total_shares = transactions.sum('share_qty')

    total_shares.zero? ? 0 : (total_cost / total_shares)
  end

  def self.net_value; end
end
