require 'spec_helper'

describe Rubymail::Bounce do

  before :each do
    @rubymail = Rubymail({:api_key => "api-key"})		

    @sample = {
      :email  => "test@sample.rubymail.org",
      :name   => "test",
      :domain => "sample.rubymail.org"
    }
  end

  describe "list bounces" do
    it "should make a GET request with the right params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      bounces_url = @rubymail.bounces(@sample[:domain]).send(:bounce_url)

      expect(Rubymail).to receive(:submit).
        with(:get, bounces_url, {}).
        and_return(sample_response)

      @rubymail.bounces(@sample[:domain]).list
    end
  end

  describe "find bounces" do
    it "should make a GET request with correct params to find given email address" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      bounces_url = @rubymail.bounces(@sample[:domain]).send(:bounce_url, @sample[:email])

      expect(Rubymail).to receive(:submit).
        with(:get, bounces_url).
        and_return(sample_response)

      @rubymail.bounces(@sample[:domain]).find(@sample[:email])
    end
  end

  describe "add bounces" do
    it "should make a POST request with correct params to add a given email address" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      bounces_url = @rubymail.bounces(@sample[:domain]).send(:bounce_url)

      expect(Rubymail).to receive(:submit).
        with(:post, bounces_url, {:address => @sample[:email]} ).
        and_return(sample_response)

      @rubymail.bounces(@sample[:domain]).add(@sample[:email])
    end
  end

  describe "destroy bounces" do
    it "should make DELETE request with correct params to remove a given email address" do
      sample_response = "{\"message\"=>\"Bounced address has been removed\", \"address\"=>\"postmaster@bsample.rubymail.org\"}"
      bounces_url = @rubymail.bounces(@sample[:domain]).send(:bounce_url, @sample[:email])

      expect(Rubymail).to receive(:submit).
        with(:delete, bounces_url).
        and_return(sample_response)

      @rubymail.bounces(@sample[:domain]).destroy(@sample[:email])
    end
  end
end