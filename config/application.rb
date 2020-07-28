require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Ticketing
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    
    config.action_mailer.default_url_options = { host: ENV['HOST'] }

    config.i18n.available_locales = [:en, :km, :th, :vi, :zh]
    config.i18n.default_locale = :km


    config.active_storage.service = :amazon
  end
end
