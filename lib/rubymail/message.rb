module Rubymail
    class Message
        def initialize(rubymail, domain)
            @rubymail = rubymail
            @domain = domain
        end
        
        def send_email(parameters={})
            Rubymail.submit(:post, messages_url, parameters)
        end

        private 
    end

end