class PortfolioController < ApplicationController
  before_action :check_trader_approved?
  before_action :set_user_stocks_with_positive_shares
  before_action :set_user_transactions

  def index
    @stock_shares = @stocks.uniq(&:ticker)
                    .each_with_object({}) do |stock, hash|
                      hash[stock.company_name] = stock.transactions.total_shares(current_user.id, stock.id).to_i
                    end
    console
  end

  def show
    @stock = Stock.find(params[:id])
  end

  private

  def set_user_stocks_with_positive_shares
    @stocks = Stock.with_positive_total_shares(current_user.id).each(&:set_or_fetch_stock_data)
  end

  def set_user_transactions
    @transactions = current_user.transactions
  end
end
