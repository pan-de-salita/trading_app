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
    updated_stock = Stock.find(stock.id)
    updated_stock.set_or_fetch_stock_data

    share_qty * (share_price - updated_stock.price)
  end

  def self.avg_price
    transactions = where(transaction_type: :buy) || 0

    total_cost = transactions.sum('share_qty * share_price')
    total_shares = transactions.sum('share_qty')

    return 0 if total_shares.zero?

    total_cost / total_shares
  end

  def self.net_value; end
end
