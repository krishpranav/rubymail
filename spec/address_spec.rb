require 'spec_helper'

describe Rubymail::Address do

  before :each do
    @sample = "foo@rubymail.net"
  end

  describe "validate an address" do
    it "should require a public api key" do
      rubymail = Rubymail({:api_key => "api-key"})
      expect { rubymail.addresses }.to raise_error(ArgumentError, ":public_api_key is a required argument to validate addresses")
    end
    it "should make a GET request with correct params to find a given webhook" do
      rubymail = Rubymail({:api_key => "api-key", :public_api_key => "public-api-key"})

      sample_response = "{\"is_valid\":true,\"address\":\"foo@rubymail.net\",\"parts\":{\"display_name\":null,\"local_part\":\"foo\",\"domain\":\"rubymail.net\"},\"did_you_mean\":null}"
      validate_url = rubymail.addresses.send(:address_url, 'validate')

      expect(Rubymail).to receive(:submit).
        with(:get, validate_url, {:address => @sample}).
        and_return(sample_response)

      rubymail.addresses.validate(@sample)
    end
  end
end