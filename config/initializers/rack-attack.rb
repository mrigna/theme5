class Rack::Attack::Request < ::Rack::Request
      def fps?
        '193.191.211.19' == env['HTTP_X_FORWARDED_FOR']
      end
end

  
Rack::Attack.whitelist("allow from fps") {|req| req.fps? }
