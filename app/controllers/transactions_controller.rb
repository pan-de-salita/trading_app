class TransactionsController < ApplicationController
  before_action :check_trader_approved?

  def index
    @transactions = current_user.transactions
  end

  def create
    stock_price = Stock.find(transaction_params[:stock_id].to_i).price
    # added merge as a workaround for disabled fields
    @transaction = current_user
                   .transactions
                   .build(transaction_params.merge({
                                                     share_price: stock_price,
                                                     amount: transaction_params[:share_qty].to_i * stock_price
                                                   }))

    return unless @transaction.save

    case transaction_params[:transaction_type]
    when 'buy'
      redirect_to stock_path(@transaction.stock_id), notice: 'Stock successfully bought.'
    when 'sell'
      # NOTE: The Sell transaction_type is accessible only through Portfolio views.
      # For every intended Sell attempt, its corresponding stock price is automatically updated.
      redirect_to portfolio_index_path, notice: 'Stock successfully sold.'
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :share_price, :share_qty, :transaction_type, :stock_id)
  end
end
