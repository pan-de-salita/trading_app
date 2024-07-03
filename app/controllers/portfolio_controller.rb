class PortfolioController < ApplicationController
  before_action :check_trader_approved?
  before_action :set_user_stocks_with_positive_shares
  before_action :set_user_transactions

  def index
    console
  end

  def show
    @stock = Stock.find(params[:id])
  end

  private

  def set_user_stocks_with_positive_shares
    @stocks = current_user.stocks.with_positive_total_shares.each(&:set_or_fetch_stock_data)
  end

  def set_user_transactions
    @transactions = current_user.transactions
  end
end
