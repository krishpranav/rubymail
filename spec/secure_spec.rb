require 'spec_helper'
require './spec/helpers/rubymail_helper.rb'

RSpec.configure do |c|
  c.include RubymailHelper
end

describe Rubymail::Secure do

  before :each do
    @rubymail = Rubymail({:api_key => "some-api-key"})   # used to get the default values
  end

  it "generate_request_auth helper should generate a timestamp, a token and a signature" do
    timestamp, token, signature = generate_request_auth("some-api-key")

    expect(timestamp).to_not    be_nil
    expect(token.length).to     eq 50
    expect(signature.length).to eq 64
  end

  it "check_request_auth should return true for a recently generated authentication" do
    timestamp, token, signature = generate_request_auth("some-api-key")

    result = @rubymail.secure.check_request_auth(timestamp, token, signature)

    expect(result).to be true
  end

  it "check_request_auth should return false for an authentication generated more than 5 minutes ago" do
    timestamp, token, signature = generate_request_auth("some-api-key", -6)

    result = @rubymail.secure.check_request_auth(timestamp, token, signature)

    expect(result).to be false
  end

  it "check_request_auth should return true for an authentication generated any time when the check offset is 0" do
    timestamp, token, signature = generate_request_auth("some-api-key", -6)

    result = @rubymail.secure.check_request_auth(timestamp, token, signature, 0)

    expect(result).to be true
  end

  it "check_request_auth should return false for a different api key, token or signature" do
    timestamp, token, signature = generate_request_auth("some-different-api-key")

    result = @rubymail.secure.check_request_auth(timestamp, token, signature)

    expect(result).to be false
  end

end