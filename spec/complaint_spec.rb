require 'spec_helper'

describe Rubymail::Complaint do

  before :each do
    @rubymail = Rubymail({:api_key => "api-key"})

    @sample = {
      :email  => "test@sample.rubymail.org",
      :name   => "test",
      :domain => "sample.rubymail.org"
    }
  end

  describe "list complaints" do
    it "should make a GET request with the right params" do
      sample_response = <<EOF
{
  "total_count": 1,
  "items": [
      {
          "count": 2,
          "created_at": "Tue, 15 Nov 2011 08:25:11 GMT",
          "address": "romanto@profista.com"
      }
  ]
}
EOF

      complaints_url = @rubymail.complaints(@sample[:domain]).send(:complaint_url)

      expect(Rubymail).to receive(:submit).
        with(:get, complaints_url, {}).
        and_return(sample_response)

      @rubymail.complaints(@sample[:domain]).list
    end
  end


  describe "add complaint" do
    it "should make a POST request with correct params to add a given email address to complaint from a tag" do
      sample_response = <<EOF
{
  "message": "Address has been added to the complaints table",
  "address": "#{@sample[:email]}"
}
EOF

      complaints_url = @rubymail.complaints(@sample[:domain]).send(:complaint_url)

      expect(Rubymail).to receive(:submit)
        .with(:post, complaints_url, {:address => @sample[:email]})
        .and_return(sample_response)

      @rubymail.complaints(@sample[:domain]).add(@sample[:email])
    end
  end


  describe "find complaint" do
    it "should make a GET request with the right params to find given email address" do
      sample_response = <<EOF
{
  "complaint": {
      "count": 2,
      "created_at": "Tue, 15 Nov 2011 08:25:11 GMT",
      "address": "romanto@profista.com"
  }
}
EOF

      complaints_url = @rubymail.complaints(@sample[:domain]).send(:complaint_url, @sample[:email])

      expect(Rubymail).to receive(:submit)
        .with(:get, complaints_url)
        .and_return(sample_response)

      @rubymail.complaints(@sample[:domain]).find(@sample[:email])
    end
  end


  describe "delete complaint" do
    it "should make a DELETE request with correct params to remove a given email address" do
      sample_response = <<EOF
{
    "message": "Complaint event has been removed",
    "address": "#{@sample[:email]}"}"
}
EOF

      complaints_url = @rubymail.complaints(@sample[:domain]).send(:complaint_url, @sample[:email])

      expect(Rubymail).to receive(:submit)
        .with(:delete, complaints_url)
        .and_return(sample_response)

      @rubymail.complaints(@sample[:domain]).destroy(@sample[:email])
    end
  end

end