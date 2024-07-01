class PortfolioController < ApplicationController
  def index
    @stocks = current_user.stocks
    @transactions = current_user.transactions
    console
  end
end

