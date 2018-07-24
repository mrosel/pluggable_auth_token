require 'spec_helper'
describe Users::SessionsController do
  let(:user) {
    { user: { email: "email@example.com", password: "badPassword"} }
  }

  it "POST /users/sign_in" do
    pending("contoller test for new session")
    post '/users/sign_in', user
    response.status.should eql(401)
  end
end
