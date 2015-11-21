class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Not possible to protect the whole application anymore: there's public pages
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
  stored_location_for(resource) ||
    if resource.is_a?(Admin)
      admin_root
    else
      choices_path(resource)
    end
end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :photo
  end
end
