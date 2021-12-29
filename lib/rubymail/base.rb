module Rubymail
    class Base

      def initialize(options)
        Rubymail.rubymail_host    = options.fetch(:rubymail_host)    { "api.rubymail.net" }
        Rubymail.protocol        = options.fetch(:protocol)        { "https" }
        Rubymail.api_version     = options.fetch(:api_version)     { "v3" }
        Rubymail.test_mode       = options.fetch(:test_mode)       { false }
        Rubymail.api_key         = options.fetch(:api_key)         { raise ArgumentError.new(":api_key is a required argument to initialize Rubymail") if Rubymail.api_key.nil? }
        Rubymail.domain          = options.fetch(:domain)          { nil }
        Rubymail.webhook_url     = options.fetch(:webhook_url)     { nil }
        Rubymail.public_api_key  = options.fetch(:public_api_key)  { nil }
      end
  
      def base_url
        "#{Rubymail.protocol}://api:#{Rubymail.api_key}@#{Rubymail.rubymail_host}/#{Rubymail.api_version}"
      end
  
      def public_base_url
        "#{Rubymail.protocol}://api:#{Rubymail.public_api_key}@#{Rubymail.rubymail_host}/#{Rubymail.api_version}"
      end
  
      def mailboxes(domain = Rubymail.domain)
        Rubymail::Mailbox.new(self, domain)
      end
  
      def messages(domain = Rubymail.domain)
        @messages ||= Rubymail::Message.new(self, domain)
      end
  
      def routes
        @routes ||= Rubymail::Route.new(self)
      end
  
      def bounces(domain = Rubymail.domain)
        Rubymail::Bounce.new(self, domain)
      end
  
      def domains
        Rubymail::Domain.new(self)
      end
  
      def unsubscribes(domain = Rubymail.domain)
        Rubymail::Unsubscribe.new(self, domain)
      end
  
      def webhooks(domain = Rubymail.domain, webhook_url = Rubymail.webhook_url)
        Rubymail::Webhook.new(self, domain, webhook_url)
      end
  
      def addresses(domain = Rubymail.domain)
        if Rubymail.public_api_key.nil?
          raise ArgumentError.new(":public_api_key is a required argument to validate addresses")
        end
        Rubymail::Address.new(self)
      end
  
      def complaints(domain = Rubymail.domain)
        Rubymail::Complaint.new(self, domain)
      end
  
      def log(domain=Rubymail.domain)
        Rubymail::Log.new(self, domain)
      end
  
      def lists
        @lists ||= Rubymail::MailingList.new(self)
      end
  
      def list_members(address)
        Rubymail::MailingList::Member.new(self, address)
      end
  
      def secure
        Rubymail::Secure.new(self)
      end
    end
  
  
    def self.submit(method, url, parameters={})
      begin
        JSON.parse(Client.new(url).send(method, parameters))
      rescue => e
        error_code = e.http_code
        error_message = begin
          JSON(e.http_body)["message"]
        rescue JSON::ParserError
          ''
        end
        error = Rubymail::Error.new(
          :code => error_code || nil,
          :message => error_message || nil
        )
        if error.handle.kind_of? Rubymail::ErrorBase
          raise error.handle
        else
          raise error
        end
      end
    end
  
    class << self
      attr_accessor :api_key,
                    :api_version,
                    :protocol,
                    :rubymail_host,
                    :test_mode,
                    :domain,
                    :webhook_url,
                    :public_api_key
  
      def configure
        yield self
        true
      end
      alias :config :configure
    end
  end