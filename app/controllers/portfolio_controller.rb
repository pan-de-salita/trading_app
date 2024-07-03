class PortfolioController < ApplicationController
  before_action :check_trader_approved?

  def index
    @stocks = current_user.stocks
                          .select {|s| s.transactions.total_shares > 0 }
    @transactions = current_user.transactions
    console
  end

  def show
    @stocks = current_user.stocks
                          .select {|s| s.transactions.total_shares > 0 }
    @transactions = current_user.transactions
    @stock = Stock.find(params[:id])
  end
end
