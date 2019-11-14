# frozen_string_literal: true

require_relative 'boot'
# require 'carrierwave'

%w(
  active_model/railtie
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  action_cable/engine
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LibraryExercise
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.generators.javascript_engine :js
    config.generators.test_framework :rspec
    config.generators.template_engine :haml
    config.load_defaults 6.0
    config.time_zone = 'Kyiv'


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
