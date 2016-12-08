# Extend the devise sessions controller
# to support JSON based authentication and issuing a JWT.
class Users::SessionsController < Devise::SessionsController

  require 'auth_token'

  def create

    # This is the default behavior from devise - view the sessions controller source:
    # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb#L16
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?

    # Here we're deviating from the standard behavior by issuing our JWT
    # to any JS based client.
    token = AuthToken.new(payload: { user_id: resource.id }).token
    # contents = AuthToken.new(token: token).decoded

    render json: {user: resource.email, token: token}

  end

end
