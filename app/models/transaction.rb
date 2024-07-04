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

  def self.total_shares(user_id = nil, stock_id = nil)
    return unless user_id && stock_id

    buy_transaction_qty = Transaction.where(user_id:, stock_id:, transaction_type: 'buy').sum('share_qty')
    sell_transaction_qty = Transaction.where(user_id:, stock_id:, transaction_type: 'sell').sum('share_qty')
    buy_transaction_qty - sell_transaction_qty
  end

  def self.avg_price(user_id = nil, stock_id = nil)
    return unless user_id && stock_id

    User.find(user_id)
        .transactions
        .filter { |transaction| transaction.stock_id == stock_id }
        .each_with_index
        .each_with_object({ total_shares: 0, avg_price: 0.0, buy_counter: 0 }) do |(transaction, idx), hash|
      if transaction.transaction_type == 'buy'
        hash[:total_shares] = hash[:total_shares] + transaction.share_qty
        hash[:buy_counter] += 1
        hash[:avg_price] = (hash[:avg_price] + transaction.share_price) / hash[:buy_counter]
      elsif transaction.transaction_type == 'sell'
        hash[:total_shares] = hash[:total_shares] - transaction.share_qty
      end

      if hash[:total_shares].zero? && idx.positive?
        hash[:avg_price] = 0.0
        hash[:buy_counter] = 0
      end
    end[:avg_price]
  end

  def self.net_value; end
end
