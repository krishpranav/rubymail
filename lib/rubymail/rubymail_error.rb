module Rubymail
    class Error
        attr_accessor :error

        def initialize(options={})
            @error =
                case options[:code]
                when 200
                    # 200 status code[success status code]
                when 404
                    Rubymail::NotFound.new(options[:message])
                when 400
                    Rubymail::BadRequest.new(options[:message])
                when 401
                    Rubymail::Unauthorized.new(options[:message])
                when 402
                    Rubymail::RequestFailed.new(options[:message])
                else
                    Rubymail::ErrorBase.new(options[:message])
                end
            end

        def hanndle
            return error.handle
        end
    end
    
    class ErrorBase < StandardError
        def handle
            return self
        end

        class NotFound < ErrorBAase
    end
                
    end
end