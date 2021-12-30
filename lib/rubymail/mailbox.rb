module Rubymail
    class Mailbox
  
      def initialize(rubymail, domain)
        @rubymail = rubymail
        @domain  = domain
      end
      
      def list(options={})
        Rubymail.submit(:get, mailbox_url, options)["items"]
      end
      
      def create(mailbox_name, password)
        address = "#{mailbox_name}@#{@domain}"
        Rubymail.submit(
          :post,
          mailbox_url,
          {
            :mailbox => address,
            :password => password
          }
        )
      end
  
      def update_password(mailbox_name, password)
        Rubymail.submit :put, mailbox_url(mailbox_name), :password => password
      end
  
      def destroy(mailbox_name)
        Rubymail.submit :delete, mailbox_url(mailbox_name)
      end
  
  
      private

      def mailbox_url(mailbox_name=nil)
        "#{@rubymail.base_url}/#{@domain}/mailboxes#{'/' + mailbox_name if mailbox_name}"
      end
  
    end
  end