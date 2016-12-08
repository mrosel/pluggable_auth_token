require 'jwt'
require 'active_support/all'

class AuthToken
  DEFAULT_EXPIRE_INTERVAL = 1.year

  attr_accessor :payload, :token, :expire_interval

  def initialize(args={})
    @expire_interval = args[:expire_interval] || DEFAULT_EXPIRE_INTERVAL
    @payload    = args[:payload]
    @token      = args[:token]
    @expiration = @expire_interval.from_now.to_time.to_i
    @token      ||= issue if args[:payload]
  end

  def issue
    @payload[:expiration] = expiration # Set expiration 
    @token =  JWT.encode(@payload, Rails.application.secrets.secret_key_base)
  end

  def valid?
    begin
      !expired? && !decoded.blank?
    rescue
      false
    end
  end

  # reset token if expired
  def expiration
    @expiration = expired? ? @expire_interval.from_now.to_time.to_i : @expiration
  end

  def expired?
    @token.blank? || Time.at(decoded[:expiration]) > Time.zone.now.to_time.to_i
  end

  def decoded
    @token.blank? ? false : JWT.decode(@token, Rails.application.secrets.secret_key_base).first.symbolize_keys
  end
end
