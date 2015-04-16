class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :require_login, :set_locale
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def not_authenticated
    flash[:warning] = t(:login_alert)
    redirect_to login_path
  end
end

#    locale = if current_user
#               current_user.locale
#             elsif params[:locale]
#               params[:locale]
#             else
#               http_accept_language.compatible_language_from(I18n.available_locales)
#             end
#    if locale && I18n.available_locales.include?(locale.to_sym)
#      session[:locale] = I18n.locale = locale.to_sym
#    end
