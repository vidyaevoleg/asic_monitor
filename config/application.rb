require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Monitoring
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.active_job.queue_adapter = :sidekiq
    config.autoload_paths += %W(
      #{config.root}/lib
      #{config.root}/app
    )
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'hotel.miningup.ru'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
      end
    end
  end
end
