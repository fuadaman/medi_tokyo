class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    requested = session[:locale]&.to_sym
    I18n.locale = if I18n.available_locales.include?(requested)
                    requested
                  else
                    I18n.default_locale
                  end
  end

  def set_language
    session[:locale] = params[:locale]
    redirect_back fallback_location: root_path
  end

  helper_method :current_locale

  def current_locale
    I18n.locale
  end
end
