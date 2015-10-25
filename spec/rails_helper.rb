require 'spec_helper'
require 'shoulda/matchers'

RSpec.configure do |config|
  config.include Shoulda::Matchers
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
