module Rubymail
    class Secure
      def initialize(rubymail)
        @rubymail = rubymail
      end
      
      def check_request_auth(timestamp, token, signature, offset=-5)
        if offset != 0
          offset = Time.now.to_i + offset * 60
          return false if timestamp < offset
        end
        
        return signature == OpenSSL::HMAC.hexdigest(
          OpenSSL::Digest::Digest.new('sha256'),
          Rubymail.api_key,
          '%s%s' % [timestamp, token])
      end
    end
  end