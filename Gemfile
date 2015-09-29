source 'https://rubygems.org'

ruby '2.2.2'
gem 'rails', '4.2.0'

gem 'pg'
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'turbolinks'
gem 'will_paginate', '~> 3.0.6'

gem 'puma'

gem 'routemaster-client', '~> 1.1'
gem 'routemaster-drain'

gem 'redis'
gem 'redis-namespace'
gem 'sidekiq'
gem 'sidetiq'

gem 'twitter-bootstrap-rails'

group :development do
  gem 'foreman'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '~> 3.0'
  gem 'dotenv-rails'
end

group :test do
  gem 'guard-rspec'
  gem 'database_cleaner'
end

group :staging1, :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm', require: false
  gem 'honeybadger', require: false
end
