# suite of helper functions authenticate a user based off a jwt
# uses a jwt like a cookie and should never be exposed to the user
module PluggableAuthToken
  module MagicTokenHeader
    def initialize(headers: )
      self.headers = headers.symbolize_keys
    end
    # part of authtoken
    def verify_jwt_token
      !(authorization_header.blank? ||
          !valid_token)
    rescue UnauthorizedError => error
      show_unauthorized_errors(error)
    end

    def jwt_user(id: :user_id)
      uid = valid_token.decoded[id]
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
      headers[:HTTP_AUTHORIZATION] || raise(UnauthorizedError, 'HTTP_AUTHORIZATION header required')
    end

    class UnauthorizedError < StandardError ; end

    private
    attr_accessor :headers
  end
end
