class RepoSynchronizationJob
  include Sidekiq::Worker
  sidekiq_options queue: :high, retry: 10

  def before_enqueue(user_id, gitlab_token)
    user = User.find(user_id)
    user.update_attribute(:refreshing_repos, true)
  end

  def perform(user_id, gitlab_token)
    user = User.find(user_id)
    synchronization = RepoSynchronization.new(user, gitlab_token)
    synchronization.start
    user.update_attribute(:refreshing_repos, false)
  end
end
