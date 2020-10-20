ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!


class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:baby_id].nil?
  end

  # Log in as a particular user.
  def log_in_as(baby)
    session[:baby_id] = baby.id
  end
end

class ActionDispatch::IntegrationTest

  # Log in as a particular user.
  def log_in_as(baby, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: baby.email,
                                          password: password,
                                          remember_me: remember_me,
                                          date_price: baby.date_price,
                                          text_price: baby.text_price } }
  end

  # Add more helper methods to be used by all tests here...
end
