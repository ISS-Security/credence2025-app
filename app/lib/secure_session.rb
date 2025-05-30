# frozen_string_literal: true

require 'redis'
require_relative 'secure_message'

# Encrypt and Decrypt JSON encoded sessions
class SecureSession
  ## Any use of this library must setup configuration information
  def self.setup(redis_url)
    @redis_url = redis_url
  end

  ## Class methods to create and retrieve cookie salt
  SESSION_SECRET_BYTES = 64

  # Generate secret for sessions
  def self.generate_secret
    SecureMessage.encoded_random_bytes(SESSION_SECRET_BYTES)
  end

  def self.wipe_redis_sessions
    redis = Redis.new(url: @redis_url)
    redis.keys.each do |session_id| # rubocop:disable Style/HashEachMethods
      redis.del session_id
    end
  end

  ## Instance methods to store and retrieve encrypted session data
  def initialize(session)
    @session = session
  end

  def set(key, value)
    @session[key] = SecureMessage.encrypt(value).to_s
  end

  def get(key)
    return nil unless @session && @session[key]

    SecureMessage.new(@session[key]).decrypt
  end

  def delete(key)
    @session.delete(key)
  end
end
