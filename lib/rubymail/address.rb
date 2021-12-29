module Rubymail
    class Address
      def initialize(rubymail)
        @rubymail = rubymail
      end
  
      def validate(email)
        Rubymail.submit :get, address_url('validate'), {:address => email}
      end
  
      private
  
      def address_url(action)
        "#{@rubymail.public_base_url}/address/#{action}"
      end
    end
  end