$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'bundler/setup'
require 'rails/all'
require 'devise'
require "auth_token"
require "pluggable_auth_token"
require 'pry'

Bundler.setup
Bundler.require(:default, Rails.env)

Dir[File.join(__dir__, 'spec', 'support', '*.rb')].each { |file| require file }

module Users
  class SessionsController
  end

  class RegistrationsController
  end
end
