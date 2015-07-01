Rack::Attack.whitelist('allow from fps') do |req|
    # Requests are allowed if the return value is truthy
  '193.191.211.19' == req.params['HTTP_X_FORWARDED_FOR']
end
