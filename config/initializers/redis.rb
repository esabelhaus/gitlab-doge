Sidekiq.configure_server do |config|
  config.average_scheduled_poll_interval = 5
  config.redis = { url: Rails.application.secrets.redis_url, namespace: 'gitlab-doge' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.secrets.redis_url, namespace: 'gitlab-doge' }
end
