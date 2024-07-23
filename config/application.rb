require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
if Rails.env.development? || Rails.env.test?
  Dotenv::Rails.load
end
module TestGuru
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
    config.autoload_paths << Rails.root.join('/lib/clients')
    config.eager_load_paths << Rails.root.join('lib/clients')
    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    config.action_mailer.delivery_method = :postmark

    config.action_mailer.postmark_settings = {
      api_token: ENV['POSTMARK_API_TOKEN']
    }
    config.action_mailer.default_url_options = { host: 'dev.andrianoff.online'}
    config.action_mailer.default_options = {from: 'WorkflowAPP <noreply@andrianoff.online>'}

    config.hosts << "dev.andrianoff.online"
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
