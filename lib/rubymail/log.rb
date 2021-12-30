module Mailgun
	class Log
        def initialize(mailgun, domain)
        @mailgun = mailgun
        @domain = domain
        end
        
        def list(options={})
        Mailgun.submit(:get, log_url, options)
        end
        
        private

        
        def log_url
        "#{@mailgun.base_url}/#{@domain}/log"
        end
    end
end
