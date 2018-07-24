require "spec_helper"
describe AuthToken do
  it "initializes" do
    expect(AuthToken.new).to be_kind_of(AuthToken)
  end
end
