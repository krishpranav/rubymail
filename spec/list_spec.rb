require 'spec_helper'

describe Rubymail::MailingList do

  before :each do
    @rubymail = Rubymail({:api_key => "api-key"})		

    @sample = {
      :email      => "test@sample.rubymail.org",
      :list_email => "dev@samples.rubymail.org",
      :name       => "test",
      :domain     => "sample.rubymail.org"
    }
  end

  describe "list mailing lists" do
    it "should make a GET request with the right params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      expect(Rubymail).to receive(:submit)
      .with(:get, "#{@rubymail.lists.send(:list_url)}", {}).and_return(sample_response)

      @rubymail.lists.list
    end
  end

  describe "find list adress" do
    it "should make a GET request with correct params to find given email address" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      expect(Rubymail).to receive(:submit)
      .with(:get, "#{@rubymail.lists.send(:list_url, @sample[:list_email])}")
      .and_return(sample_response)

      @rubymail.lists.find(@sample[:list_email])
    end
  end

  describe "create list" do
    it "should make a POST request with correct params to add a given email address" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      expect(Rubymail).to receive(:submit)
      .with(:post, "#{@rubymail.lists.send(:list_url)}", {:address => @sample[:list_email]})
      .and_return(sample_response)

      @rubymail.lists.create(@sample[:list_email])
    end
  end

  describe "update list" do
    it "should make a PUT request with correct params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      expect(Rubymail).to receive(:submit)
      .with(:put, "#{@rubymail.lists.send(:list_url, @sample[:list_email])}", {:address => @sample[:email]})
      .and_return(sample_response)

      @rubymail.lists.update(@sample[:list_email], @sample[:email])
    end
  end

  describe "delete list" do
    it "should make a DELETE request with correct params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      expect(Rubymail).to receive(:submit)
      .with(:delete, "#{@rubymail.lists.send(:list_url, @sample[:list_email])}")
      .and_return(sample_response)

      @rubymail.lists.delete(@sample[:list_email])
    end
  end

end