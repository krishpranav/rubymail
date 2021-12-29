require 'spec_helper'

describe Rubymail::Log do

  before :each do
    @rubymail = Rubymail({:api_key => "api-key"})   

    @sample = {
      :email  => "test@sample.rubymail.org",
      :name   => "test",
      :domain => "sample.rubymail.org"
    }
  end

  describe "send email" do
    it "should make a POST request to send an email" do

      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      expect(Rubymail).to receive(:submit)
      .with(:get, "#{@rubymail.lists.send(:list_url, @sample[:list_email])}")
      .and_return(sample_response)

      @rubymail.lists.find(@sample[:list_email])

      sample_response = "{\"message\": \"Queued. Thank you.\",\"id\": \"<20111114174239.25659.5817@samples.rubymail.org>\"}"
      parameters = {
        :to => "cooldev@your.rubymail.domain",
        :subject => "missing tps reports",
        :text => "yeah, we're gonna need you to come in on friday...yeah.",
        :from => "lumberg.bill@initech.rubymail.domain"
      }
      expect(Rubymail).to receive(:submit)                            \
        .with(:post, @rubymail.messages.messages_url, parameters) \
        .and_return(sample_response)

      @rubymail.messages.send_email(parameters)
    end
  end

end