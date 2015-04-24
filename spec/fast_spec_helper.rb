$: << File.expand_path("../..", __FILE__)

require "attr_extras"
require "byebug"
require "webmock/rspec"
require "active_support"
require "active_support/core_ext"
require 'rspec-sidekiq'

Dir["spec/support/**/*.rb"].each { |f| require f }

ENV["HOST"] = "test.host"
ENV["SECRET_KEY_BASE"] = "test-key"
ENV["DOGE_GITLAB_USERID"] = "1"
ENV["DOGE_GITLAB_TOKEN"] = "dogegitlabtoken"
ENV["ENABLE_HTTPS"] = "no"
ENV["QUEUE"]= "low"
ENV["GITLAB_ENDPOINT"]= "http://example.com"
ENV["CHANGED_FILES_THRESHOLD"] = "300"
ENV["EXEMPT_ORGS"] = "thoughtbot,billybob"
ENV["LOG_LEVEL"] = "debug"

RSpec::Sidekiq.configure do |config|
  config.warn_when_jobs_not_processed_by_sidekiq = false
end

RSpec.configure do |config|
  config.order = "random"
  WebMock.disable_net_connect!(allow_localhost: true)
  include ApiHelper
  Sidekiq::Testing.inline!
end
