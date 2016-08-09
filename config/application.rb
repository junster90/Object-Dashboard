require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ObjectDashboard
  class Application < Rails::Application
    config.autoload_paths << "#{Rails.root}/lib/exceptions"
    config.eager_load_paths << "#{Rails.root}/lib/exceptions"
  end
end
