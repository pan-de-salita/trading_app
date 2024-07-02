class PortfolioController < ApplicationController
  before_action :authorize_confirmed_trader!

  def index
    @stocks = current_user.stocks
    @transactions = current_user.transactions
    console
  end
end

