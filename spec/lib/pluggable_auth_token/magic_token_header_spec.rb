require 'spec_helper'

describe PluggableAuthToken::MagicTokenHeader do
  class MagicTokenHeader
    include PluggableAuthToken::MagicTokenHeader
  end

  let(:default_args) {{ payload: { user_id: 1 } }}
  let(:token) { AuthToken.new(default_args) }
  let(:request) { instance_double("Request", headers: { HTTP_AUTHORIZATION: "Token #{token.token}" }) }
  let(:new_request) { MagicTokenHeader.new(headers: request.headers) }

  let!(:user) { double("User", id: 1) }

  before do
    allow(Rails).to receive_message_chain(:application, :secrets, :secret_key_base)
                .and_return('asdf')
    allow(user).to receive(:find).and_return(user)
    Time.zone = ActiveSupport::TimeZone["UTC"]
  end

  it '#authorization_header' do
    expect(new_request.authorization_header).to eq request.headers[:HTTP_AUTHORIZATION]
  end

  # jwt_token
  it { expect(new_request.jwt_token).to_not be_nil }

  # valid_token
  it { expect(new_request.valid_token).to_not be_nil }

  it '#jwt_user' do
    pending('jwt_user find user')
    expect(new_request.jwt_user).to_not be_nil
  end

  it '#verify_jwt_token' do
    expect(new_request.verify_jwt_token).to_not be_nil
  end

  # UnauthorizedError
  describe 'Failures' do
    let(:request) { instance_double("Request", :headers => { HTTP_AUTHORIZATION: "Token " }) }
    it { expect{new_request.valid_token}.to raise_error PluggableAuthToken::MagicTokenHeader::UnauthorizedError }
    pending('fail verify_jwt_token')
    pending('fail cannot find user')
  end
end


__END__
# suite of helper functions authenticate a user based off a jwt
# uses a jwt like a cookie and should never be exposed to the user
module PluggableAuthToken
  module MagicTokenHeader
    # part of authtoken
    def verify_jwt_token
      !(authorization_header.blank? ||
          !valid_token)
    rescue UnauthorizedError => error
      show_unauthorized_errors(error)
    end

    def jwt_user
      uid = valid_token.decoded[:user_id]
      User.find(uid)
    end

    def valid_token
      token = AuthToken.new(jwt_token)
      raise(UnauthorizedError, 'INVALID Token') unless token.valid?
      token
    end

    def jwt_token
      token = authorization_header.split('Token ').last || raise(UnauthorizedError, 'AUTHORIZATION Token required')
      { token: token }
    end

    def authorization_header
      request.headers['HTTP_AUTHORIZATION'] || raise(UnauthorizedError, 'HTTP_AUTHORIZATION required')
    end

    class UnauthorizedError < StandardError ; end
  end
end
