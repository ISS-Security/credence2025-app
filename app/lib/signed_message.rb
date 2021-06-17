# frozen_string_literal: true

require 'base64'
require 'rbnacl'

# Encrypt and Decrypt from Database
class SignedMessage
  class KeypairError < StandardError; end

  # Call setup once to pass in config variable with SIGNING_KEY attribute
  def self.setup(signing_key64)
    @signing_key = Base64.strict_decode64(signing_key64)
  rescue StandardError
    raise KeypairError, 'Signing key not found'
  end

  def self.sign(message)
    signature = RbNaCl::SigningKey.new(@signing_key)
      .sign(message.to_json)
      .then { |sig| Base64.strict_encode64(sig) }

    { data: message, signature: signature }
  end
end
