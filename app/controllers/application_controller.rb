class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private
  def default_url_options
    I18n.locale == I18n.default_locale ? {} : { lang: I18n.locale }
  end
  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
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
      flash[:notice] = t('devise.sessions.signed_in_admin', name: current_user.first_name)
      admin_tests_path
    else
      flash[:notice] = t('devise.sessions.signed_in_user', name: current_user.first_name)
      stored_location_for(resource_or_scope) || super
    end
  end
end
