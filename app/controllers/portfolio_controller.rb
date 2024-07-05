class PortfolioController < ApplicationController
  before_action :check_trader_approved?
  before_action :set_user_stocks_with_positive_shares
  before_action :set_user_transactions

  def index
    console
    @stock_shares = @transactions.group_by(&:stock_id).each_with_object(Hash.new(0)) do |(stock_id, transactions), hash|
hash[Stock.find(stock_id).company_name] = Transaction.total_shares(transactions)
end

  end

  def show
    @stock = Stock.find(params[:id])
  end

  private

  def set_user_stocks_with_positive_shares
    @stocks = Stock.with_positive_total_shares(current_user.transactions).each(&:set_or_fetch_stock_data)
  end

  def set_user_transactions
    @transactions = current_user.transactions
  end
end
