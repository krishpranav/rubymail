module Rubymail
    class Client
        attr_reader :url
        
        def initialize(url)
            @url = url
        end

        def get(params = {})
            request_path = path
            request_path += "?#{URI.encode_www_form(params)}" if params.any?

            request = Net::HTTP::Get.new(request_path)

            make_request(request)
        end

        def post(params = {})
            request = Net::HTTP::Post.new(path)
            request.set_form_data(params)

            make_request(request)
        end

        def put(params = {})
            request = Net::HTTP::Put.new(path)
            request.set_form_data(params)

            make_request(request)
        end

        def delete(params = {})
            request = Net::HTTP::Delete.new(path)
            request.set_form_data(params)
            
            make_request(request)
        end
    end
end