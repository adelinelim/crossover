ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

helpers = Rails.root.join("test", "test_helper", "*.{rb}").to_s
Dir[helpers].each { |f| require(f) }

# DatabaseCleaner.strategy = :transaction
# DatabaseCleaner.clean_with(:truncation)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include FactoryGirl::Syntax::Methods

  # before do
  #   setup_services
  # end

  # def setup
  #   DatabaseCleaner.start
  # end
  #
  # def teardown
  #   DatabaseCleaner.clean
  # end
end
