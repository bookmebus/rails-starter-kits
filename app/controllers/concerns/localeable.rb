# frozen_string_literal: true

module Localeable
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale
  end


  def switch_locale(&action)
    locale = I18n.default_locale

    if params[:locale].present? && I18n.available_locales.include?( params[:locale].to_sym)
      locale = params[:locale]
    elsif browser_locale.present? && I18n.available_locales.include?( browser_locale.to_sym)
      locale = browser_locale
    end

    I18n.with_locale(locale, &action)
  end

  def browser_locale
    if request.env['HTTP_ACCEPT_LANGUAGE'].present?
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    else
      nil
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

end