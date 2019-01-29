class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resorces)
    user_path(current_user)
  end

  def after_destroy_user_session_path(resorces)
  	root_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])

  end
end
