module Rubymail
    class Error
      attr_accessor :error
  
      def initialize(options={})
        @error =
          case options[:code]
          when 200
            # 200 status code [success code]
          when 404
            Rubymail::NotFound.new(options[:message])
          when 400
            Rubymail::BadRequest.new(options[:message])
          when 401
            Rubymail::Unauthorized.new(options[:message])
          when 402
            Rubymail::ResquestFailed.new(options[:message])
          when 500, 502, 503, 504
            Rubymail::ServerError.new(options[:message])
          else
            Rubymail::ErrorBase.new(options[:message])
          end
      end
  
      def handle
        return error.handle
      end
    end
  
    class ErrorBase < StandardError
      def handle
        return self
      end
    end
  
    class NotFound < ErrorBase
      def handle
        return nil
      end
    end
  
    class BadRequest < ErrorBase
    end
  
    class Unauthorized < ErrorBase
    end
  
    class ResquestFailed < ErrorBase
    end
  
    class ServerError < ErrorBase
    end
  end