

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :gitlab,
    :site => ENV.fetch("GITLAB_URL"),
    :v => 'v3'
  )
end
