class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private
  def admin_only
    unless current_user.admin?
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
  def after_sign_in_path_for(resource_or_scope)
    if current_user&.admin?
      flash[:notice] = "Привет, #{current_user.name}! Не забудь, что ты Админ"
      admin_tests_path
    else
      flash[:notice] = "Привет, #{current_user.name}!"
      stored_location_for(resource_or_scope) || super
    end
  end
end
