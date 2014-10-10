# Run Coverage report
require 'simplecov'
SimpleCov.start do
  add_filter 'spec/dummy'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Views', 'app/views'
  add_group 'Libraries', 'lib'
end

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'database_cleaner'
require 'ffaker'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

# Requires factories defined in spree_core
require 'spree/testing_support/factories'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/url_helpers'

# Requires factories defined in lib/spree_test_extension_one/factories.rb
require 'spree_test_extension_one/factories'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  # == URL Helpers
  #
  # Allows access to Spree's routes in specs:
  #
  # visit spree.admin_path
  # current_path.should eql(spree.products_path)
  config.include Spree::TestingSupport::UrlHelpers

  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
  config.color = true

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Capybara javascript drivers require transactional fixtures set to false, and we use DatabaseCleaner
  # to cleanup after each test instead.  Without transactional fixtures set to false the records created
  # to setup a test will be unavailable to the browser, which runs under a seperate server instance.
  config.use_transactional_fixtures = false

  # Ensure Suite is set to use transactions for speed.
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  # Before each spec check if it is a Javascript test and switch between using database transactions or not where necessary.
  config.before :each do
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  # After each spec clean the database.
  config.after :each do
    DatabaseCleaner.clean
  end

  config.fail_fast = ENV['FAIL_FAST'] || false
end



# unless defined? SPREE_ROOT
#   ENV["RAILS_ENV"] = "test"
#   case
#   when ENV["SPREE_ENV_FILE"]
#     require ENV["SPREE_ENV_FILE"]
#   when File.dirname(__FILE__) =~ %r{vendor/SPREE/vendor/extensions}
#     require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../../../")}/config/environment"
#   else
#     require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../")}/config/environment"
#   end
# end
# require "#{SPREE_ROOT}/spec/spec_helper"

# if File.directory?(File.dirname(__FILE__) + "/scenarios")
#   Scenario.load_paths.unshift File.dirname(__FILE__) + "/scenarios"
# end
# if File.directory?(File.dirname(__FILE__) + "/matchers")
#   Dir[File.dirname(__FILE__) + "/matchers/*.rb"].each {|file| require file }
# end

# Spec::Runner.configure do |config|
#   # config.use_transactional_fixtures = true
#   # config.use_instantiated_fixtures  = false
#   # config.fixture_path = RAILS_ROOT + '/spec/fixtures'

#   # You can declare fixtures for each behaviour like this:
#   #   describe "...." do
#   #     fixtures :table_a, :table_b
#   #
#   # Alternatively, if you prefer to declare them only once, you can
#   # do so here, like so ...
#   #
#   #   config.global_fixtures = :table_a, :table_b
#   #
#   # If you declare global fixtures, be aware that they will be declared
#   # for all of your examples, even those that don't use them.
# end