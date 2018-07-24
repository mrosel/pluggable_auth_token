require 'spec_helper'
describe Users::RegistrationsController do
  let(:new_user) {
    { user: { email: "email@example.com", password: "new_password"} }
  }

  it "POST /users/registration" do
    pending("controller test for new user")
    post '/users/registration', new_user
    response.status.should eql(200)
  end
end
