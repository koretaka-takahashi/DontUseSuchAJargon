require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DontUseSuchAJargon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local

    #【NameError: uninitialized constant User::ImageUploaderの対策】Carrierwaveでのエラーの模様。
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
