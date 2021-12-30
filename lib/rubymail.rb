require "json"
require "multimap/lib/multimap"
require "multimap/lib/multiset"
require "multimap/lib/nested_multimap"

require "rubymail/rubymail_error"
require "rubymail/base"
require "rubymail/domain"
require "rubymail/route"
require "rubymail/mailbox"
require "rubymail/bounce"
require "rubymail/unsubscribe"
require "rubymail/webhook"
require "rubymail/complaint"
require "rubymail/log"
require "rubymail/list"
require "rubymail/list/member"
require "rubymail/message"
require "rubymail/secure"
require "rubymail/address"
require "rubymail/client"

#require "startup"

def Rubymail(options={})
  options[:api_key] = Rubymail.api_key if Rubymail.api_key
  options[:domain] = Rubymail.domain if Rubymail.domain
  options[:webhook_url] = Rubymail.webhook_url if Rubymail.webhook_url
  options[:public_api_key] = Rubymail.public_api_key if Rubymail.public_api_key
  Rubymail::Base.new(options)
end