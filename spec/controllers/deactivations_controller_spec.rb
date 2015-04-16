require "spec_helper"

describe DeactivationsController, "#create" do
  before :each do
    allow(GitlabToken).to receive(:token_by_dn).and_return('gitlabdogetoken')
  end
  context "when deactivation succeeds" do
    it "returns successful response" do
      token = 'gitlabdogetoken'
      membership = create(:membership)
      repo = membership.repo
      activator = double(:repo_activator, deactivate: true)
      allow(RepoActivator).to receive(:new).and_return(activator)
      stub_sign_in(membership.user)

      post :create, repo_id: repo.id, format: :json

      expect(response.code).to eq "201"
      expect(response.body).to eq RepoSerializer.new(repo).to_json
      expect(activator).to have_received(:deactivate)
      expect(RepoActivator).to have_received(:new).
        with(repo: repo, gitlab_token: token)
    end
  end

  context "when deactivation fails" do
    it "returns error response" do
      token = 'gitlabdogetoken'
      membership = create(:membership)
      repo = membership.repo
      activator = double(:repo_activator, deactivate: false)
      allow(RepoActivator).to receive(:new).and_return(activator)
      stub_sign_in(membership.user)

      post :create, repo_id: repo.id, format: :json

      expect(response.code).to eq "502"
      expect(activator).to have_received(:deactivate)
      expect(RepoActivator).to have_received(:new).
        with(repo: repo, gitlab_token: token)
    end
  end
end
