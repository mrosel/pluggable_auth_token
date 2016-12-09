class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  def flash(args={})
    puts args.inspect
  end
end
