module Rubymail
    class Domain
      def initialize(rubymail)
        @rubymail = rubymail
      end

      def list(options={})
        Rubymail.submit(:get, domain_url, options)["items"] || []
      end
  
      def find(domain)
        Rubymail.submit :get, domain_url(domain)
      end
  
      def create(domain, opts = {})
        opts = {name: domain}.merge(opts)
        Rubymail.submit :post, domain_url, opts
      end
  
      def delete(domain)
        Rubymail.submit :delete, domain_url(domain)
      end
  
      def verify(domain)
        Rubymail.submit :put, "#{domain_url(domain)}/verify"
      end
  
      private
  
      def domain_url(domain = nil)
        "#{@rubymail.base_url}/domains#{'/' + domain if domain}"
      end
    end
  end