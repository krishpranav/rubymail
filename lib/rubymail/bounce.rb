module Rubymail
    class Bounce

        def initialize(rubymail, domain)
            @rubymail = rubymail
            @domain = domain
        end

        def list(options={})
            Rubymail.submit(:get, bounce_url, options)["items"] || []
        end

        def find(email)
            Rubymail.submit :get, bounce_url(email)
        end

        def add(email, options={})
            Rubymail.submit :post, bounce_url, {:address => email}.merge(options)
        end

        def destroy(email)
            Rubymail.submit :delete, bounce_url(email)
        end
    end
end