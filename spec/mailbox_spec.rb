require 'spec_helper'

describe Rubymail::Mailbox do

  before :each do
    @rubymail = Rubymail({:api_key => "api-key"})		

    @sample = {
      :email  => "test@sample.rubymail.org",
      :mailbox_name => "test",
      :domain => "sample.rubymail.org"
    }
  end

  describe "list mailboxes" do
    it "should make a GET request with the right params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      mailboxes_url = @rubymail.mailboxes(@sample[:domain]).send(:mailbox_url)

      expect(Rubymail).to receive(:submit).
        with(:get,mailboxes_url, {}).
        and_return(sample_response)

      @rubymail.mailboxes(@sample[:domain]).list
    end
  end

  describe "create mailbox" do
    it "should make a POST request with the right params"	do
      mailboxes_url = @rubymail.mailboxes(@sample[:domain]).send(:mailbox_url)
      expect(Rubymail).to receive(:submit)
        .with(:post, mailboxes_url,
          :mailbox  => @sample[:email],
          :password => @sample[:password])
        .and_return({})

      @rubymail.mailboxes(@sample[:domain]).create(@sample[:mailbox_name], @sample[:password])
    end
  end

  describe "update mailbox" do
    it "should make a PUT request with the right params" do
      mailboxes_url = @rubymail.mailboxes(@sample[:domain]).send(:mailbox_url, @sample[:mailbox_name])
      expect(Rubymail).to receive(:submit)
        .with(:put, mailboxes_url, :password => @sample[:password])
        .and_return({})

      @rubymail.mailboxes(@sample[:domain]).
        update_password(@sample[:mailbox_name], @sample[:password])
    end
  end

  describe "destroy mailbox" do
    it "should make a DELETE request with the right params" do
      mailboxes_url = @rubymail.mailboxes(@sample[:domain]).send(:mailbox_url, @sample[:name])
      expect(Rubymail).to receive(:submit)
        .with(:delete, mailboxes_url)
        .and_return({})

      @rubymail.mailboxes(@sample[:domain]).destroy(@sample[:name])
    end
  end
end