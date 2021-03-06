require "spec_helper"

describe Rubymail::Route do

  before :each do
    @rubymail = Rubymail({:api_key => "api-key"})		
    @sample_route_id = "a45cd"
  end

  describe "list routes" do
    before :each do
      sample_response = <<EOF
{
  "total_count": 0,
  "items": []
}
EOF.to_json

      expect(Rubymail).to receive(:submit).
        with(:get, "#{@rubymail.routes.send(:route_url)}", {}).
        and_return(sample_response)
    end

    it "should make a GET request with the right params" do
      @rubymail.routes.list
    end

    it "should respond with an Array" do
      expect(@rubymail.routes.list).to be_kind_of(Array)
    end
  end

  describe "get route" do
    it "should make a GET request with the right params" do
      sample_response = <<EOF
{
  "route": {
      "description": "Sample route",
      "created_at": "Wed, 15 Feb 2012 13:03:31 GMT",
      "actions": [
          "forward(\"http://myhost.com/messages/\")",
          "stop()"
      ],
      "priority": 1,
      "expression": "match_recipient(\".*@samples.rubymail.org\")",
      "id": "4f3bad2335335426750048c6"
  }
}
EOF

      expect(Rubymail).to receive(:submit).
        with(:get, "#{@rubymail.routes.send(:route_url, @sample_route_id)}").
        and_return(sample_response)

      @rubymail.routes.find @sample_route_id
    end
  end

  describe "create route" do
    it "should make a POST request with the right params" do
      options = {}

      options[:description] = "test_route"
      options[:priority]    = 1
      options[:expression]  = [:match_recipient, "sample.rubymail.org"]
      options[:action]      = [[:forward, "http://test-site.com"], [:stop]]

      expect(Rubymail).to receive(:submit)
        .with(:post, @rubymail.routes.send(:route_url), instance_of(Hash))
        .and_return("{\"route\": {\"id\": \"@sample_route_id\"}}")

      @rubymail.routes.create(
        options[:description],
        options[:priority],
        options[:expression],
        options[:action],
      )
    end
  end

  describe "update route" do
    it "should make a PUT request with the right params" do
      options = { description: "test_route" }

      expect(Rubymail).to receive(:submit)
        .with(:put, "#{@rubymail.routes.send(:route_url, @sample_route_id)}", { 'description' => ["test_route"] })
        .and_return("{\"id\": \"#{@sample_route_id}\"}")
      @rubymail.routes.update @sample_route_id, options
    end
  end

  describe "delete route" do
    it "should make a DELETE request with the right params" do
      expect(Rubymail).to receive(:submit).
        with(:delete, "#{@rubymail.routes.send(:route_url, @sample_route_id)}").
        and_return("{\"id\": \"#{@sample_route_id}\"}")
      @rubymail.routes.destroy @sample_route_id
    end
  end
end