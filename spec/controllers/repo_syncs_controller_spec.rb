require 'spec_helper'

describe RepoSyncsController, '#create' do
  before :each do
    allow(GitlabToken).to receive(:token_by_dn).and_return('gitlabdogetoken')
  end
  it 'enqueues repo sync job and sets refreshing_repos to true' do
    user = create(:user)
    stub_sign_in(user)
    allow(JobQueue).to receive(:push)

    post :create

    expect(user.reload).to be_refreshing_repos

    expect(JobQueue).to have_received(:push).
      with(RepoSynchronizationJob, user.id, user.gitlab_token_string)
  end
end
