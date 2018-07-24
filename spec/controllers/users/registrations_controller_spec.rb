require 'spec_helper'
describe Users::RegistrationsController do
  let(:new_user) { build(:user) }

  it 'POST /users/registration' do
    pending('controller test for new user')
    post '/users/registration', { user: new_user }
    response.status.should eql(200)
  end
end
