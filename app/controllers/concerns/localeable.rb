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
    end

    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

end