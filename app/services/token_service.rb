require 'base64'

class TokenService
  def self.encode(payload, secret_key, expiration = 24.hours.from_now)
    payload[:exp] = expiration.to_i
    Base64.urlsafe_encode64(payload.to_json + '.' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret_key, payload.to_json))
  end

  def self.decode(token, secret_key)
    decoded_token = Base64.urlsafe_decode64(token)
    payload, signature = decoded_token.split('.')
    return nil unless payload && signature

    payload_data = JSON.parse(Base64.urlsafe_decode64(payload))
    verified_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret_key, payload)
    return nil unless signature == verified_signature

    payload_data
  rescue
    nil
  end
end