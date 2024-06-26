class ApplicationController < ActionController::Base
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
end
