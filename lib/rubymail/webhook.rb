module Rubymail
    class Webhook
      attr_accessor :default_webhook_url, :domain
  
      def initialize(rubymail, domain, url)
        @rubymail = rubymail
        @domain = domain
        @default_webhook_url = url
      end
  
      def available_ids
        %w(bounce deliver drop spam unsubscribe click open).map(&:to_sym)
      end
  
      def list
        Rubymail.submit(:get, webhook_url)["webhooks"] || []
      end
  
      def find(id)
        Rubymail.submit :get, webhook_url(id)
      end
  
      def create(id, url=default_webhook_url)
        params = {:id => id, :url => url}
        Rubymail.submit :post, webhook_url, params
      end
  
      def update(id, url=default_webhook_url)
        params = {:url => url}
        Rubymail.submit :put, webhook_url(id), params
      end
  
      def delete(id)
        Rubymail.submit :delete, webhook_url(id)
      end
  
      private
  
      def webhook_url(id=nil)
        "#{@rubymail.base_url}/domains/#{domain}/webhooks#{'/' + id if id}"
      end
    end
  end