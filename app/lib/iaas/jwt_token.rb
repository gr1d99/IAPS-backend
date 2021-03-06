module Iaas
  module JwtToken
    ALGORITHM = "HS256".freeze
    SECRET = Rails.application.credentials.secret_key_base

    class << self
      def encode(payload)
        payload = add_claims(payload)

        JWT.encode(payload, JwtToken::SECRET, JwtToken::ALGORITHM)
      end

      def decode(token)
        JWT.decode(token, JwtToken::SECRET, true, algorithm: JwtToken::ALGORITHM)
      end

      private

      def add_claims(payload)
        exp = Time.zone.now.to_i + 36_000
        payload[:exp] = exp
        payload
      end
    end
  end
end
