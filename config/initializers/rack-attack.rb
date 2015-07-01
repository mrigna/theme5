Rack::Attack.whitelist('allow from fps') do
    # Requests are allowed if the return value is truthy
  '193.191.211.19' == env['HTTP_X_FORWARDED_FOR']
end
