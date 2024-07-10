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

  def gain_loss(current_share_price)
    share_qty * (share_price - current_share_price)
  end

  def self.total_shares(stock_transactions)
    grouped_transactions = stock_transactions.group_by(&:transaction_type)

    buy_transactions = grouped_transactions['buy']
    buy_transaction_qty = buy_transactions.nil? ? 0 : buy_transactions.sum(&:share_qty)

    sell_transactions = grouped_transactions['sell']
    sell_transaction_qty = sell_transactions.nil? ? 0 : sell_transactions.sum(&:share_qty)

    buy_transaction_qty - sell_transaction_qty
  end

  def self.avg_price(stock_transactions)
    stock_transactions
      .each_with_index
      .each_with_object(
        {
          total_shares: 0,
          avg_price: 0.0,
          buy_counter: 0
        }
      ) do |(transaction, idx), hash|
      if transaction.transaction_type == 'buy'
        hash[:total_shares] += transaction.share_qty
        hash[:buy_counter] += 1
        hash[:avg_price] = (hash[:avg_price] + transaction.share_price) / hash[:buy_counter]
      elsif transaction.transaction_type == 'sell'
        hash[:total_shares] -= transaction.share_qty
      end

      if hash[:total_shares].zero? && idx.positive?
        hash[:avg_price] = 0.0
        hash[:buy_counter] = 0
      end
    end[:avg_price]
  end

  def self.net_value; end
end
