class ApplicationController < ActionController::Base
  helper_method :authorize_trader_of_any_confirmation_type!
  helper_method :authorize_confirmed_trader!

  # NOTE: Devise Sessions Controller override:
  # - if admin, redirect to traders dashboard
  # - if user, redirect to stock search page (stocks_path)
  # Documentation: https://github.com/heartcombo/devise/blob/main/lib/devise/controllers/helpers.rb#L217
  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
        return stocks_path if resource.trader?
        return root_path if resource.admin?
      else
        super
      end
  end

  def authorize_trader_of_any_confirmation_type!
    return if current_user.present? && current_user.trader?

    redirect_to root_path
  end

  def authorize_confirmed_trader!
    return if current_user.present? && current_user.active_for_authentication? && current_user.trader?

    redirect_to root_path
  end
end
