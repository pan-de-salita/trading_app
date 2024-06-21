class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_user, only: %i[edit update destroy]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # UserMailer.with(user: @user).account_initialized.deliver_now
      redirect_to root_path, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User deleted successfully.'
  end

  private

  def authorize_admin
    redirect_to root_path, alert: 'Only administrators can access this page.' unless current_user.admin?

    # NOTE: Another cool way to implement this method is to store the admin authorization
    # data in an .env file, and then to perform the authorization logic by calling the
    # data from the .env file here. Note that the 'dotenv' gem will need to be added.
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
