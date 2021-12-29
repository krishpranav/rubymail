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

  describe "list log" do
    it "should make a GET request with the right params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      log_url = @rubymail.log(@sample[:domain]).send(:log_url)
      expect(Rubymail).to receive(:submit).
        with(:get, log_url, {}).
        and_return(sample_response)

      @rubymail.log(@sample[:domain]).list
    end
  end

end