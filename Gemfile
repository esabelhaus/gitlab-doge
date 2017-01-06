source "https://rubygems.org"

ruby "2.1.6"

gem "active_model_serializers", "~> 0.10.3"
gem 'activerecord-session_store'
gem "angularjs-rails", "~> 1.6.1"
gem "attr_extras", "~> 5.1.0"
gem "bourbon", "~> 4.2.7"
gem "coffee-rails", "~> 4.2.1"
gem "coffeelint", "~> 1.14.0"
gem "dotenv-rails", "~> 2.1.1"
gem "font-awesome-rails", "~> 4.7.0.1"
gem "haml-rails", "~> 0.9.0"
gem "high_voltage"
gem "jquery-rails", "~> 4.2.2"
gem "jshintrb", "~> 0.3.0"
gem "jlint", "~> 0.1.3"
#This is here in the event your exernal gitlab db is mysql
gem "mysql2", "~> 0.4.5"
gem "neat", "~> 1.8.0"
gem "gitlab", "3.7.0"
gem "omniauth"
gem "omniauth-dice", "~> 0.2"
gem "paranoia", "~> 2.0"
gem "pg", "~> 0.19.0"
gem "rb-readline"
gem 'responders', '~> 2.0'
gem "rails", "~> 4.2.7"
gem "sinatra"
gem "sidekiq", "~> 4.2.7"
gem "sidekiq-failures", "~> 0.4.3"
gem "rubocop", "~> 0.35.0"
gem "sass-rails", "~> 5.0.6"
gem "uglifier", ">= 1.0.3"
gem "unicorn", "~> 5.2.0"

group :staging, :production do
  gem "rails_12factor"
end

group :development do
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "brakeman"
  gem "byebug"
  gem "foreman"
  gem "konacha"
  gem "poltergeist"
  gem "rspec-rails", ">= 2.14"
  gem "quiet_assets"
  gem "pry"
  gem "pry-rails"
  gem "thin"
end

group :test do
  gem "capybara", "~> 2.11.0"
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "launchy"
  gem "shoulda-matchers"
  gem "webmock"
  gem "rspec-sidekiq"
  gem "sentry-raven"
  gem 'simplecov'
end
