# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment', __FILE__)

if ENV['NEW_RELIC_LICENSE_KEY']
  require 'newrelic_rpm'
  NewRelic::Agent.manual_start
end

run Rails.application
