class FrontEndController < ApplicationController
  around_action :switch_locale

  def switch_locale(&action)
    locale = I18n.available_locales.include?(params[:locale].to_sym) ? params[:locale] : I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
