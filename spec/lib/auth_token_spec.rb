require 'spec_helper'

describe AuthToken do
  let(:default_args) {{ payload: { user_id: 1 } }}

  before do
    allow(Rails).to receive_message_chain(:application, :secrets, :secret_key_base)
                .and_return('asdf')
    Time.zone = ActiveSupport::TimeZone["UTC"]
  end

  describe 'initializes' do
    let(:token) { AuthToken.new(default_args) }

    it 'with null' do
      expect(AuthToken.new).to be_kind_of(AuthToken)
    end

    it 'new' do
      expect(token).to be_kind_of(AuthToken)
      # it needs to issue the token
      expect(token.token).to_not be_nil
    end
  end

  describe 'class methods' do
    let!(:token) { AuthToken.new(default_args) }
    let!(:expiration) { (Time.zone.now + 1.year).to_i }
    it { expect(token.valid?).to be_truthy }
    it { expect(token.expiration).to eq expiration }
    it { expect(token.expired?).to be_falsey }
    it { expect(token.decoded).to have_key :user_id }

    # TODO: reset token if expired
    pending('timecop expire')
  end
end
