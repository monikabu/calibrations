require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Calibration
  class Application < Rails::Application
    config.active_record.schema_format = :sql
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths << File.join(config.root, 'lib')
  end
end
