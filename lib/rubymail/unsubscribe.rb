module Rubymail
    class Unsubscribe
      def initialize(rubymail, domain)
        @rubymail = rubymail
        @domain  = domain
      end
      
      def list(options={})
        Mailgun.submit(:get, unsubscribe_url, options)["items"]
      end
  
      def find(email)
        Mailgun.submit :get, unsubscribe_url(email)
      end
  
      def add(email, tag='*')
        Mailgun.submit :post, unsubscribe_url, {:address => email, :tag => tag}
      end
  
      def remove(email)
        Mailgun.submit :delete, unsubscribe_url(email)
      end
      
      private
  
      def unsubscribe_url(address=nil)
        "#{@rubymail.base_url}/#{@domain}/unsubscribes#{'/' + address if address}"
      end
      
    end
  end