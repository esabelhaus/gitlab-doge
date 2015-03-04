require 'spec_helper'

describe RepoSyncsController, '#create' do
  it 'enqueues repo sync job and sets refreshing_repos to true' do
    token = "usergitlabtoken"
    user = create(:user)
    stub_sign_in(user, token)
    allow(JobQueue).to receive(:push)

    post :create

    expect(user.reload).to be_refreshing_repos

    expect(JobQueue).to have_received(:push).
      with(RepoSynchronizationJob, user.id, token)
  end
end
