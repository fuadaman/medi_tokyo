class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = session[:locale] || :en
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
