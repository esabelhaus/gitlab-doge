OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dice, {
    cas_server:          "#{ENV['CAS_SERVER']}",
    authentication_path: "#{ENV['CAS_AUTHENTICATION_PATH']}",
    use_callback_url:    "#{ENV['OA_DICE_USE_CALLBACK_URL']}",
    primary_visa:        "#{ENV['PRIMARY_VISA_FIELD']}",
    dnc_options: { :transformation => ENV['DNC_TRANSFORMATION'] }, # see `dnc` gem for all options
    ssl_config: {
      ca_file:     "#{ENV['SSL_CA_FILE_PATH']}",
      client_cert: "#{ENV['SSL_CLIENT_CERT_PATH']}",
      client_key:  "#{ENV['SSL_CLIENT_KEY_PATH']}"
    }
  }
end
