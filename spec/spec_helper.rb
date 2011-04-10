ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../rails_app/config/environment.rb',  __FILE__)

require 'bundler'
Bundler.setup

require 'rspec'
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

ActiveRecord::Migrator.migrate File.expand_path('../rails_app/db/migrate/', __FILE__)

Rspec.configure do |config|
  config.mock_with :mocha
  
  config.use_transactional_fixtures = true
end