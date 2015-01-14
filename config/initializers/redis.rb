uri   = URI.parse(ENV.fetch("REDIS_URL"))
redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
REDIS = Redis::Namespace.new("routemaster-timemachine-#{Rails.env}", redis: redis)
