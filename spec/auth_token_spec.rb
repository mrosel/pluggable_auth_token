require "spec_helper"

require "auth_token"

describe AuthToken do
  it "initializes" do
      expect(AuthToken.new).to be_kind_of(AuthToken)
  end
end