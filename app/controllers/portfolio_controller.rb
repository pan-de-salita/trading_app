class PortfolioController < ApplicationController
  before_action :check_trader_approved?
  before_action :update_current_user_stocks

  def index
    @stocks = current_user.stocks.with_positive_total_shares
    @transactions = current_user.transactions
    console
  end

  def show
    @stocks = current_user.stocks.with_positive_total_shares
    @transactions = current_user.transactions
    @stock = Stock.find(params[:id])
  end

  private

  def update_current_user_stocks
    current_user.stocks.with_positive_total_shares.each(&:set_or_fetch_stock_data)
  end
end
