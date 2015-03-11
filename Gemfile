source "https://rubygems.org"

ruby "2.2.0", :engine => "jruby", :engine_version => "9.0.0.0.pre1"

gem "active_model_serializers", "~>0.8.1"
gem 'activerecord-session_store'
gem "angularjs-rails", "~> 1.2.22"
gem "attr_extras", "~> 3.1.0"
gem "bourbon", "~> 3.2.3"
gem "coffee-rails", "~> 4.0.1"
gem "coffeelint", "~> 0.3.0"
gem "font-awesome-rails", "~> 4.1.0.0"
gem "haml-rails", "~> 0.5.3"
gem "high_voltage"
gem "jquery-rails", "~> 3.1.1"
gem "jshintrb", "~> 0.2.4"
#This is here in the event your exernal gitlab db is mysql
gem "activerecord-jdbcmysql-adapter"
gem "neat", "~> 1.5.1"
gem "gitlab", "3.2.0"
gem "omniauth"
gem "omniauth-dice", "~> 0.2"
gem "paranoia", "~> 2.0"
gem "activerecord-jdbcpostgresql-adapter"
gem "rb-readline"
gem "rails", "4.1.5"
gem "sinatra"
gem "sidekiq", "~> 3.2.2"
gem "sidekiq-failures", "~> 0.4.3"
gem "rubocop", "0.29.1"
gem "sass-rails", "~> 4.0.2"
gem "uglifier", ">= 1.0.3"
gem "dotenv-rails", "~> 0.11.1"

group :staging, :production do
  gem "rails_12factor"
end

group :development, :test do
  gem "awesome_print"
  gem "foreman"
  gem "konacha"
  gem "poltergeist"
  gem "rspec-rails", ">= 2.14"
  gem "quiet_assets"
  gem "pry"
  gem "pry-rails"
  gem "puma"
end

group :test do
  gem "capybara", "~> 2.4.0"
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "launchy"
  gem "shoulda-matchers"
  gem "webmock"
  gem "codeclimate-test-reporter"
  gem "rspec-sidekiq"
  gem "sentry-raven"
end
