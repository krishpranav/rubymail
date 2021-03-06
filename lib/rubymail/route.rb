module Rubymail
    class Route
      def initialize(rubymail)
        @rubymail = rubymail
      end
  
      def list(options={})
        Rubymail.submit(:get, route_url, options)["items"] || []
      end
  
      def find(route_id)
        Rubymail.submit(:get, route_url(route_id))["route"]
      end
  
      def create(description, priority, filter, actions)
        data = ::Multimap.new
  
        data['priority']    = priority
        data['description'] = description
        data['expression']  = build_filter(filter)
  
        actions = build_actions(actions)
  
        actions.each do |action|
          data['action'] = action
        end
  
        data = data.to_hash
  
        # TODO: Raise an error or return false if unable to create route
        Rubymail.submit(:post, route_url, data)["route"]["id"]
      end
  
      def update(route_id, params)
        data = ::Multimap.new
  
        params = Hash[params.map{ |k, v| [k.to_s, v] }]
  
        ['priority', 'description'].each do |key|
          data[key] = params[key] if params.has_key?(key)
        end
  
        data['expression'] = build_filter(params['expression']) if params.has_key?('expression')
  
        if params.has_key?('actions')
          actions = build_actions(params['actions'])
  
          actions.each do |action|
            data['action'] = action
          end
        end
  
        data = data.to_hash
  
        Rubymail.submit(:put, route_url(route_id), data)
      end
  
      def destroy(route_id)
        Rubymail.submit(:delete, route_url(route_id))["id"]
      end
  
      private
  
      def route_url(route_id=nil)
        "#{@rubymail.base_url}/routes#{'/' + route_id if route_id}"
      end
  
      def build_actions(actions)
        _actions = []
  
        actions.each do |action|
          case action.first.to_sym
          when :forward
            _actions << "forward(\"#{action.last}\")"
          when :stop
            _actions << "stop()"
          else
            raise Rubymail::Error.new("Unsupported action requested, see http://documentation.rubymail.net/user_manual.html#routes for a list of allowed actions")
          end
        end
  
        _actions
      end
  
  
      def build_filter(filter)
        case filter.first.to_sym
        when :match_recipient
          return "match_recipient('#{filter.last}')"
        when :match_header
          return "match_header('#{filter[1]}', '#{filter.last}')"
        when :catch_all
          return "catch_all()"
        else
          raise Rubymail::Error.new("Unsupported filter requested, see http://documentation.rubymail.net/user_manual.html#routes for a list of allowed filters")
        end
      end
    end
  end