module Rubymail
    class MailingList
      def initialize(rubymail)
        @rubymail = rubymail
      end
  
      def list(options={})
        response = Rubymail.submit(:get, list_url, options)["items"] || []
      end
  
      def find(address)
        Rubymail.submit :get, list_url(address)
      end
  
      def create(address, options={})
          params = {:address => address}
        Rubymail.submit :post, list_url, params.merge(options)
      end
  
      def update(address, new_address, options={})
        params = {:address => new_address}
        Rubymail.submit :put, list_url(address), params.merge(options)
      end		
  
      def delete(address)
          Rubymail.submit :delete, list_url(address)
      end
  
  
      private
  
      def list_url(address=nil)
        "#{@rubymail.base_url}/lists#{'/' + address if address}"
      end
      
    end
  end