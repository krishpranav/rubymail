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

    end
end