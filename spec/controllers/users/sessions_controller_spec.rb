require 'spec_helper'

describe Users::SessionsController do
  it "POST /users/sign_in" do
    post '/users/sign_in', { user: { email: "email@example.com", password: "badPassword"} }
    response.status.should eql(401)
  end
 end
