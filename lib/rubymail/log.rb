module Rubymail
	class Log
        def initialize(rubymail, domain)
        @rubymail = rubymail
        @domain = domain
        end
        
        def list(options={})
        Rubymail.submit(:get, log_url, options)
        end
        
        private

        
        def log_url
        "#{@rubymail.base_url}/#{@domain}/log"
        end
    end
end
