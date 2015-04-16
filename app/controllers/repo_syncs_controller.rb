class RepoSyncsController < ApplicationController
  respond_to :json

  def create
    unless current_user.refreshing_repos?
      before_enqueue(current_user.id)
      JobQueue.push(
        RepoSynchronizationJob,
        current_user.id,
        current_user.gitlab_token_string
      )
      head 201
    else
      head 200
    end
  end

  private

  def before_enqueue(user_id)
    user = User.find(user_id)
    user.update_attribute(:refreshing_repos, true)
  end
end
