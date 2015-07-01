Rack::Attack.whitelist('allow from fps') do |req|
    # Requests are allowed if the return value is truthy
  '193.191.211.19' == req.env['HTTP_X_REQUESTED_WITH']
end
