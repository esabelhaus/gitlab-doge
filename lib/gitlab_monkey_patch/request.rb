module Gitlab
  class Request
    # HTTParty SSL configuration
    if ENV['ENABLE_HTTPS'] == 'yes'
      ssl_ca_file ENV['SSL_CA_FILE_PATH']
      pem File.read(ENV['SSL_UNIFIED_CLIENT_CERT'])
    end
  end
end
