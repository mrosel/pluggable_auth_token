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
