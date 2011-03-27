# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require 'rubygems'
require 'bundler'
Bundler.setup
require 'rspec'
require 'rspec/autorun'
require 'webmock/rspec'
require 'rack/test'
require 'omniauth/core'
require 'omniauth/test'
require 'omniauth/oauth'

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# RSpec
RSpec.configure do |config|
  config.include WebMock
  config.include Rack::Test::Methods
  config.extend  OmniAuth::Test::StrategyMacros, :type => :strategy
end

def strategy_class
  meta = self.class.metadata
  while meta.key?(:example_group)
    meta = meta[:example_group]
  end
  meta[:describes]
end

def app
  lambda{|env| [200, {}, ['Hello']]}
end

WebMock.disable_net_connect!