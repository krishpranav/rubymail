module Rubymail
    class Base

        def initialize(options)
            Rubymail.rubymail_host    = options.fetch(:rubymail_host)    { "api.rubymail.net" }
            Rubymail.protocol        = options.fetch(:protocol)        { "https" }
            Rubymail.api_version     = options.fetch(:api_version)     { "v3" }
            Rubymail.test_mode       = options.fetch(:test_mode)       { false }
            Rubymail.api_key         = options.fetch(:api_key)         { raise ArgumentError.new(":api_key is a required argument to initialize Mailgun") if Mailgun.api_key.nil? }
            Rubymail.domain          = options.fetch(:domain)          { nil }
            Rubymail.webhook_url     = options.fetch(:webhook_url)     { nil }
            Rubymail.public_api_key  = options.fetch(:public_api_key)  { nil }
        end

    end
end