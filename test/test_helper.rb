ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def sign_in(user)
    post login_path, params: { email: user.email, password: 'password' }
  end
end

class ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
end
