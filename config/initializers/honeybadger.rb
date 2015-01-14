if ENV['EXCEPTION_SERVICE'] == 'honeybadger'

  require 'honeybadger'

  Honeybadger.configure do |config|
    config.api_key = ENV.fetch('HONEYBADGER_API_KEY')
  end

end
