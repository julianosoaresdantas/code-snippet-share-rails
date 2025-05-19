require "bcrypt" # Add this line at the top (if you need it)

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    fixtures :all # Or fixtures :users if you prefer to load only users
  end
end

require "database_cleaner/active_record"

DatabaseCleaner.strategy = :truncation
class ActiveSupport::TestCase
  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
