require 'spec_helper'

describe Rubymail::Base do

  it "should raise an error if the api_key has not been set" do
    Rubymail.config { |c| c.api_key = nil }
    expect do
      Rubymail()
    end.to raise_error ArgumentError
  end

  it "can be called directly if the api_key has been set via Rubymail.configure" do
    Rubymail.config { |c| c.api_key = "some-junk-string" }
    expect do
      Rubymail()
    end.not_to raise_error()
  end

  it "can be instanced with the api_key as a param" do
    expect do
      Rubymail({:api_key => "some-junk-string"})
    end.not_to raise_error()
  end

  describe "Rubymail.new" do
    it "Rubymail() method should return a new Rubymail object" do
      rubymail = Rubymail({:api_key => "some-junk-string"})
      expect(rubymail).to be_kind_of(Rubymail::Base)
    end
  end

  describe "resources" do
    before :each do
      @rubymail = Rubymail({:api_key => "some-junk-string"})
    end

    it "Rubymail#mailboxes should return an instance of Rubymail::Mailbox" do
      expect(@rubymail.mailboxes).to be_kind_of(Rubymail::Mailbox)
    end

    it "Rubymail#routes should return an instance of Rubymail::Route" do
      expect(@rubymail.routes).to be_kind_of(Rubymail::Route)
    end
  end

  describe "internal helper methods" do
    before :each do
      @rubymail = Rubymail({:api_key => "some-junk-string"})
    end

    describe "Rubymail#base_url" do
      it "should return https url if use_https is true" do
      expect(@rubymail.base_url).to eq "https://api:#{Rubymail.api_key}@#{Rubymail.rubymail_host}/#{Rubymail.api_version}"
      end
    end

    describe "Rubymail.submit" do
      let(:client_double) { double(Rubymail::Client) }

      it "should send method and arguments to Rubymail::Client" do
        expect(Rubymail::Client).to receive(:new)
          .with('/')
          .and_return(client_double)
        expect(client_double).to receive(:test_method)
          .with({:arg1=>"val1"})
          .and_return('{}')

        Rubymail.submit :test_method, '/', :arg1=>"val1"
      end
    end
  end

  describe "configuration" do
    describe "default settings" do
      it "api_version is v3" do
        expect(Rubymail.api_version).to eql 'v3'
      end
      it "should use https by default" do
        expect(Rubymail.protocol).to eq "https"
      end
      it "rubymail_host is 'api.rubymail.net'" do
        expect(Rubymail.rubymail_host).to eql 'api.rubymail.net'
      end

      it "test_mode is false" do
        expect(Rubymail.test_mode).to eql false
      end

      it "domain is not set" do
        expect(Rubymail.domain).to be_nil
      end
    end

    describe "setting configurations" do
      before(:each) do
        Rubymail.configure do |c|
          c.api_key = 'some-api-key'
          c.api_version = 'v2'
          c.protocol = 'https'
          c.rubymail_host = 'api.rubymail.net'
          c.test_mode = false
          c.domain = 'some-domain'
        end
      end

      after(:each) { Rubymail.configure { |c| c.domain = nil } }

      it "allows me to set my API key easily" do
        expect(Rubymail.api_key).to eql 'some-api-key'
      end

      it "allows me to set the api_version attribute" do
        expect(Rubymail.api_version).to eql 'v2'
      end

      it "allows me to set the protocol attribute" do
        expect(Rubymail.protocol).to eql 'https'
      end

      it "allows me to set the rubymail_host attribute" do
        expect(Rubymail.rubymail_host).to eql 'api.rubymail.net'
      end
      it "allows me to set the test_mode attribute" do
        expect(Rubymail.test_mode).to eql false
      end

      it "allows me to set my domain easily" do
        expect(Rubymail.domain).to eql 'some-domain'
      end
    end
  end
end