class PortfolioController < ApplicationController
  before_action :check_trader_approved?
  before_action :update_current_user_stocks

  def index
    @stocks = current_user.stocks
    @transactions = current_user.transactions
    console
  end

  private

  def update_current_user_stocks
    current_user.stocks.each(&:set_or_fetch_stock_data)
  end
end
