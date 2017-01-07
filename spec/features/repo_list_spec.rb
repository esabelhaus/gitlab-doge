require "spec_helper"

feature "Repo list", js: true do
  #pending("need to get repo syncronization short circuted")
  before do
    allow(GitlabToken).to receive(:token_by_dn).and_return('gitlabdogetoken')
  end
  scenario "user views list" do
    #allow(User).to receive(:has_repos_with_missing_information?).and_return(false)
    user = create(:user)
    repo = create(:repo, full_gitlab_name: "thoughtbot/my-repo")
    repo.users << user



    sign_in

    visit repos_path

    expect(page).to have_content repo.full_gitlab_name
  end

  scenario "user filters list" do
    #allow(User).to receive(:has_repos_with_missing_information?).and_return(false)
    user = create(:user)
    repo = create(:repo, full_gitlab_name: "thoughtbot/my-repo")
    repo.users << user

    sign_in

    visit repos_path
    find(".search").set(repo.full_gitlab_name)

    expect(page).to have_content repo.full_gitlab_name
  end

  scenario "user syncs repos" do
    token = "usergithubtoken"
    user = create(:user)
    repo = create(:repo, full_gitlab_name: "user1/test-repo")
    user.repos << repo
    stub_repo_requests(token)

    sign_in

    visit repos_path

    expect(page).to have_content(repo.full_gitlab_name)

    click_link I18n.t("sync_repos")

    expect(page).to have_text("jimtom/My-Private-Repo")
    expect(page).not_to have_text(repo.full_gitlab_name)
  end

  scenario "user signs up" do
    sign_in

    expect(page).to have_content I18n.t("syncing_repos")
  end

  scenario "user activates repo" do
    token = "usergithubtoken"
    user = create(:user)
    repo = create(:repo, private: false)
    repo.users << user
    hook_url = "http://#{ENV["HOST"]}/builds"
    stub_repo_request(repo.full_gitlab_name, token)
    stub_add_collaborator_request(repo.full_gitlab_name, token)
    stub_hook_creation_request(repo.full_gitlab_name, hook_url, token)
    stub_memberships_request
    stub_membership_update_request

    sign_in

    # find("li.repo .toggle").click

    expect(page).to have_css(".active")
    expect(page).to have_content "1 OF 1"

    visit repos_path
    #allow(User).to receive(:has_repos_with_missing_information?).and_return(false)

    expect(page).to have_css(".active")
    expect(page).to have_content "1 OF 1"
  end

  scenario "user with admin access activates organization repo" do
    user = create(:user)
    repo = create(:repo, private: false, full_gitlab_name: "testing/repo")
    repo.users << user
    hook_url = "http://#{ENV["HOST"]}/builds"
    team_id = 4567 # from fixture
    hound_user = "houndci"
    token = "usergithubtoken"
    stub_repo_with_org_request(repo.full_gitlab_name, token)
    stub_hook_creation_request(repo.full_gitlab_name, hook_url, token)
    stub_repo_teams_request(repo.full_gitlab_name, token)
    stub_user_teams_request(token)
    stub_add_user_to_team_request(hound_user, team_id, token)
    stub_memberships_request
    stub_membership_update_request

    sign_in

    # find(".repos .toggle").click

    expect(page).to have_css(".active")
    expect(page).to have_content "1 OF 1"

    visit repos_path
    #allow(User).to receive(:has_repos_with_missing_information?).and_return(false)

    expect(page).to have_css(".active")
    expect(page).to have_content "1 OF 1"
  end

  scenario "user deactivates repo" do
    user = create(:user)
    repo = create(:repo, :active)
    repo.users << user
    stub_hook_removal_request(repo.full_gitlab_name, repo.hook_id)

    sign_in

    visit repos_path
    #allow(User).to receive(:has_repos_with_missing_information?).and_return(false)
    # find(".repos .toggle").click

    expect(page).not_to have_css(".active")
    expect(page).to have_content "0 OF 1"

    visit current_path

    expect(page).not_to have_css(".active")
    expect(page).to have_content "0 OF 1"
  end

  scenario "user deactivates private repo without subscription" do
    user = create(:user)
    repo = create(:repo, :active, private: true)
    repo.users << user
    stub_hook_removal_request(repo.full_gitlab_name, repo.hook_id)

    sign_in
    visit repos_path
    #allow(User).to receive(:has_repos_with_missing_information?).and_return(false)
    # find(".repos .toggle").click

    expect(page).not_to have_css(".active")
    expect(page).to have_content "0 OF 1"

    visit current_path

    expect(page).not_to have_css(".active")
    expect(page).to have_content "0 OF 1"
  end
end
