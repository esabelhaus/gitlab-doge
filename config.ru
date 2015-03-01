# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)
if defined? ENV['RAILS_RELATIVE_ROOT_URL']
  map Dogeapp::Application.config.relative_url_root do
    run Rails.application
  end
else
  run Dogeapp::Application
end