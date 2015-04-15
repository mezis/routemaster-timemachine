source 'https://rubygems.org'

ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'will_paginate', '~> 3.0.6'

gem 'unicorn'

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

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

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
