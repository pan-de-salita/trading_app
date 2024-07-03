class Admin::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user

  def index
    @transactions = Transaction.all
  end

private

  # Make sure user cannot access admin privileges
  def authorize_user
    return if current_user.admin?

    redirect_to root_path, alert: 'You are not authorized to access this page.'
  end

end