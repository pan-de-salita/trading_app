class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: %i[edit update destroy create]
  before_action :set_user, only: %i[edit update destroy]

  def index
    # A signed-in admin cannot edit their own account.
    @users = User.all.filter { |user| user != current_user }

    @pending_users = @users.select { |user| user.status.pending? }
    @approved_users = @users.select { |user| user.status.approved? }
    @denied_users = @users.select { |user| user.status.denied? }

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge({ admin_created: true }))

    if @user.save
      redirect_to root_path, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def edit

  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      flash[:success] = 'Edit Successful.'
      if current_user.admin?
        redirect_to admin_users_path
      else
        redirect_to edit_user_registration_path
      end
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User deleted successfully.'
  end

  def approve_trader_account
    update_status('approved')
  end

  def deny_trader_account
    update_status('denied')
  end

  private

  # Make sure user cannot access admin privileges
  def authorize_user
    return if current_user.admin?

    redirect_to root_path, alert: 'You are not authorized to access this page.'
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def update_status(status)
    @user = User.find(params[:user_id])
    @user.status.update(status_type: status)

    if @user.status.denied?
      redirect_to admin_users_path, notice: "User #{@user.email} is #{status}."
    else
      redirect_to admin_users_path, notice: "User #{@user.email} is not #{status}."
    end
  end
end
