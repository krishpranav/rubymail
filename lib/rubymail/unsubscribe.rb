module Rubymail
    class Unsubscribe
        
        def initialize(rubymail, domain)
            @rubymail = rubymail
            @domain = domain
        end

        def list(options={})
            Rubymail.submit(:get, unsubscribe_url, options)["items"]
        end

        def find(email)
            Rubymail.submit :get, unsubscribe_url(email)
        end

        def add(email, tag='*')
            Rubymail.submit :post, unsubscribe_url, {:address => email, :tag => tag}
        end

        def remove(email)
            Rubymail.submit :delete, unsubscribe_url(email)
        end

        private
        
        end
    end
end