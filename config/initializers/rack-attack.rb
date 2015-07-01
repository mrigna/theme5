Rack::Attack.whitelist('allow from fps') do |request|
    # Requests are allowed if the return value is truthy
  '193.191.211.19' == request.headers["x-forwarded-for"]
end
