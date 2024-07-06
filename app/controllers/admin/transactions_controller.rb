class Admin::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user

  def index
    @transactions = Transaction.all
    
    case params[:sort_by]
    when 'created_at'
      @transactions = @transactions.order(created_at: :desc)
    when 'created_at_asc'
      @transactions = @transactions.order(created_at: :asc)
    when 'company_name'
      @transactions = @transactions.joins(:stock).order('stocks.company_name')
    when 'transaction_type'
      @transactions = @transactions.order(transaction_type: :asc)
    else
      @transactions = @transactions.order(created_at: :desc)
    end
  end


private

  # Make sure user cannot access admin privileges
  def authorize_user
    return if current_user.admin?

    redirect_to root_path, alert: 'You are not authorized to access this page.'
  end

end