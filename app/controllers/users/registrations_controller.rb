class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  def flash(args={})
    puts args.inspect
  end
  
  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      render json: resource, status: :created, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: resource.errors.messages, status: :unprocessable_entity
    end
  end
end
