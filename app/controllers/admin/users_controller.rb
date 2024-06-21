class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: %i[edit update destroy create]
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
      redirect_to root_path, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def edit
    console
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

  private

  # Make sure user cannot access admin privileges
  def authorize_user
    return if current_user.admin? || current_user == @user

    redirect_to root_path, alert: 'You are not authorized to access this page.'
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
