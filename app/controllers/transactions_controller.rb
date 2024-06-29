class TransactionsController < ApplicationController

  def index
    @transactions = current_user.transactions
  end

  # def new

  # end

  def create
    stock_price = Stock.find(transaction_params[:stock_id].to_i).price
    @transaction = current_user
    .transactions.build(transaction_params
    .merge({share_price: stock_price, amount: transaction_params[:share_qty].to_i * stock_price }))
    #added merge to as workaround for disabled fields

    if @transaction.save
      redirect_to stock_path(@transaction.stock_id), notice: "Stock successfully bought"
    end
  end


  private

  def transaction_params
    params.require(:transaction).permit(:amount, :share_price, :share_qty, :transaction_type, :stock_id)
  end

end
