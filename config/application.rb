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

    config.i18n.available_locales = %i[ en es km th vi zh ]
    config.i18n.default_locale = :en
    
    config.active_storage.service = :amazon


    if(ENV['ASSET_HOST_URL'].present?)
      config.action_controller.asset_host = ENV['ASSET_HOST_URL'] #"xxx.cloudfront.net"
    end

     # https://github.com/rails/rails/pull/34477#issuecomment-651467261
    config.active_storage.resolve_model_to_route = :cdn_proxy if ENV['ACTIVE_STORAGE_CDN'].present?
    
  end
end
