ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"

require "rails/test_help"

# Fix for Rails 7.1 + Minitest 6.0 incompatibility
# Rails' LineFiltering was written for older Minitest where Runnable.run had a different signature
# In Minitest 6.0, the signature changed from (reporter, options) to (klass, method_name, reporter)
# We need to override it with the correct signature

if ActiveSupport::TestCase.respond_to?(:run)
  # Clear the existing singleton method and redefine it with correct Minitest 6.0 signature
  class << ActiveSupport::TestCase
    remove_method :run rescue nil

    def run(klass, method_name, reporter)
      # For Rails' line filtering, we need to apply the filter to the method
      # But we don't have control over which test method is being run here
      # So we just call the parent implementation
      reporter.prerecord klass, method_name
      reporter.record klass.new(method_name).run
    end
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
