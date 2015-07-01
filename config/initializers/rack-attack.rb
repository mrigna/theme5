Rack::Attack.whitelist('allow from fps') do |req|
    # Requests are allowed if the return value is truthy
  '127.0.0.1' == req.ip
end
