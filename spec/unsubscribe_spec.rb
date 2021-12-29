require 'spec_helper'

describe Rubymail::Unsubscribe do

  before :each do
    @rubymail = Rubymail({:api_key => "api-key"})		

    @sample = {
      :email  => "test@sample.rubymail.org",
      :name   => "test",
      :domain => "sample.rubymail.org",
      :tag   => 'tag1'
    }
  end

  describe "list unsubscribes" do
    it "should make a GET request with the right params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      unsubscribes_url = @rubymail.unsubscribes(@sample[:domain]).send(:unsubscribe_url)
      expect(Rubymail).to receive(:submit).
        with(:get, unsubscribes_url, {}).
        and_return(sample_response)

      @rubymail.unsubscribes(@sample[:domain]).list
    end
  end

  describe "find unsubscribe" do
    it "should make a GET request with the right params to find given email address" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
      unsubscribes_url = @rubymail.unsubscribes(@sample[:domain]).send(:unsubscribe_url, @sample[:email])

      expect(Rubymail).to receive(:submit)
        .with(:get, unsubscribes_url)
        .and_return(sample_response)

      @rubymail.unsubscribes(@sample[:domain]).find(@sample[:email])
    end
  end

  describe "delete unsubscribe" do
    it "should make a DELETE request with correct params to remove a given email address" do
      response_message = "{\"message\"=>\"Unsubscribe event has been removed\", \"address\"=>\"#{@sample[:email]}\"}"
      unsubscribes_url = @rubymail.unsubscribes(@sample[:domain]).send(:unsubscribe_url, @sample[:email])

      expect(Rubymail).to receive(:submit)
        .with(:delete, unsubscribes_url)
        .and_return(response_message)

      @rubymail.unsubscribes(@sample[:domain]).remove(@sample[:email])
    end
  end

  describe "add unsubscribe" do
    context "to tag" do
      it "should make a POST request with correct params to add a given email address to unsubscribe from a tag" do
        response_message = "{\"message\"=>\"Address has been added to the unsubscribes table\", \"address\"=>\"#{@sample[:email]}\"}"
        expect(Rubymail).to receive(:submit)
          .with(:post, "#{@rubymail.unsubscribes(@sample[:domain]).send(:unsubscribe_url)}",{:address=>@sample[:email], :tag=>@sample[:tag]})
          .and_return(response_message)

        @rubymail.unsubscribes(@sample[:domain]).add(@sample[:email], @sample[:tag])
      end
    end

    context "on all" do
      it "should make a POST request with correct params to add a given email address to unsubscribe from all tags" do
        sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.rubymail.org\" }  ]}"
        unsubscribes_url = @rubymail.unsubscribes(@sample[:domain]).send(:unsubscribe_url)

        expect(Rubymail).to receive(:submit)
          .with(:post, unsubscribes_url, {
            :address => @sample[:email], :tag => '*'
          })
          .and_return(sample_response)

        @rubymail.unsubscribes(@sample[:domain]).add(@sample[:email])
      end
    end
  end

end