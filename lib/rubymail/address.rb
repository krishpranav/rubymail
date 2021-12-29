module Rubymail
    class Address

        def initialize(rubymail)
            @mailgun = mailgun
        end

        def validate(email)
            Rubymail.submit :get, address_url('validate'), {:address => email}
        end

        private
    end
end