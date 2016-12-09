$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'bundler/setup'
Bundler.setup

require 'rails/all'
Bundler.require(:default, Rails.env)

module Users
  class SessionsController
  end
end

require 'devise'
# Mock Rails.application.secrets.secret_key_base).first.symbolize_keys
class Rails::Application
  def self.secrets
    secret_key_base = 'b8f3ade070ece4ade4cdfe878e3dcce98ac7ba4b7509237bd1c95d639981b77ee49b38fc82a214519061ce45b054aafcc7a992b89ab033cdd095e83cbeac901b'
  end
end

require "pluggable_auth_token"

