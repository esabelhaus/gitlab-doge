class RepoSynchronizationJob
  include Sidekiq::Worker

  def done_refreshing(user)
    user.update_attribute(:refreshing_repos, false)
  end

  def perform(user_id, gitlab_token)
    user = User.find(user_id)
    synchronization = RepoSynchronization.new(user, gitlab_token)
    synchronization.start
    done_refreshing(user)
  end

  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Setting User attr :refreshing_repos back to false, be sure to check the dead jobs queue"
    done_refreshing(User.find(msg['args'][0]))
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  sidekiq_options queue: :high, retry: 10
end
