module Rubymail
    class Complaint
        def initialize(rubymail, domain)
            @rubymail = rubymail
            @domain = domain
        end

        def list(options={})
            Rubymail.submit(:get, complaint_url, options)["items"] || []
        end

        def find(email)
            Rubymail.submit :get, complaint_url(email)
        end

        def add(email)
            Rubymail.submit :post, complaint_url, {:address => email}
        end
        
    end
end