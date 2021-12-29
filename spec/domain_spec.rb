require 'spec_helper'

describe Rubymail::Domain do

  before :each do
    @rubymail = Rubymail({:api_key => "api-key"})   

    @sample = {
      :email  => "test@sample.rubymail.org",
      :name   => "test",
      :domain => "sample.rubymail.org"
    }
  end

  describe "list domains" do
    it "should make a GET request with the right params" do

      sample_response = "{\"total_count\": 1, \"items\": [{\"created_at\": \"Tue, 12 Feb 2013 20:13:49 GMT\", \"smtp_login\": \"postmaster@sample.rubymail.org\", \"name\": \"sample.rubymail.org\", \"smtp_password\": \"67bw67bz7w\" }]}"
      domains_url = @rubymail.domains.send(:domain_url)

      expect(Rubymail).to receive(:submit).
        with(:get, domains_url, {}).
        and_return(sample_response)

      @rubymail.domains.list
    end
  end

  describe "find domains" do
    it "should make a GET request with correct params to find given domain" do
      sample_response = "{\"domain\": {\"created_at\": \"Tue, 12 Feb 2013 20:13:49 GMT\", \"smtp_login\": \"postmaster@bample.rubymail.org\", \"name\": \"sample.rubymail.org\", \"smtp_password\": \"67bw67bz7w\" }, \"receiving_dns_records\": [], \"sending_dns_records\": []}"
      domains_url = @rubymail.domains.send(:domain_url, @sample[:domain])

      expect(Rubymail).to receive(:submit).
        with(:get, domains_url).
        and_return(sample_response)

      @rubymail.domains.find(@sample[:domain])
    end
  end

  describe "add domains" do
    it "should make a POST request with correct params to add a domain" do
      sample_response = "{\"domain\": {\"created_at\": \"Tue, 12 Feb 2013 20:13:49 GMT\", \"smtp_login\": \"postmaster@sample.rubymail.org\",\"name\": \"sample.rubymail.org\",\"smtp_password\": \"67bw67bz7w\"}, \"message\": \"Domain has been created\"}"
      domains_url = @rubymail.domains.send(:domain_url)

      expect(Rubymail).to receive(:submit).
        with(:post, domains_url, {:name => @sample[:domain]} ).
        and_return(sample_response)

      @rubymail.domains.create(@sample[:domain])
    end
  end

  describe "delete domain" do
    it "should make a DELETE request with correct params" do
      sample_response = "{\"message\": \"Domain has been deleted\"}"
      domains_url = @rubymail.domains.send(:domain_url, @sample[:domain])

      expect(Rubymail).to receive(:submit).
        with(:delete, domains_url).
        and_return(sample_response)

      @rubymail.domains.delete(@sample[:domain])
    end
  end

  describe 'verify domain' do
    it 'should make a PUT request to verify with correct params' do
      sample_response = "{\"domain\": {\"created_at\": \"Tue, 12 Feb 2013 20:13:49 GMT\", \"smtp_login\": \"postmaster@bample.rubymail.org\", \"name\": \"sample.rubymail.org\", \"smtp_password\": \"67bw67bz7w\", \"state\": \"active\"}, \"message\": \"Domain DNS records have been updated\", \"receiving_dns_records\": [], \"sending_dns_records\": []}"
      verify_domain_url = "#{@rubymail.domains.send(:domain_url, @sample[:domain])}/verify"

      expect(Rubymail).to receive(:submit)
        .with(:put, verify_domain_url)
        .and_return(sample_response)

      @rubymail.domains.verify(@sample[:domain])
    end
  end
end