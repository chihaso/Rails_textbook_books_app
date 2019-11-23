# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_user(user_email:, password:)
    visit "/users/sign_in"
    within(".new_user") do
      fill_in("user[email]", with: user_email)
      fill_in("user[password]", with: password)
    end
    click_button "commit"
  end
end
