# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  #
  # NOTE: Is .active_for_authentication? called via super?
  # According to Devise's cource code (https://github.com/heartcombo/devise/blob/a259ff3c28912a27329727f4a3c2623d3f5cb6f2/lib/devise/models/authenticatable.rb), it might be. See:
  #
  # (.valid_for_authentication?) Check if the current object is valid for authentication.
  # This method and find_for_authentication are the methods used in a Warden::Strategy
  # to check if a model should be signed in or not.
  #
  # However, you should not overwrite this method, you should overwrite active_for_authentication?
  # and inactive_message instead.
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
