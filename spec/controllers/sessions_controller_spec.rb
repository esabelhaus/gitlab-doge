require "spec_helper"
require "omniauth_helper"

describe "User accesses site, is redirected to dice, then session controller" do
  before do
    allow(GitlabToken).to receive(:token_by_dn).and_return('gitlabdogetoken')
  end
  describe "#create" do
    context "with valid new user" do
      it "creates new user" do
        mock_dice
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:dice]

        expect { visit '/auth/dice' }.to change { User.count }.by(1)
        user = User.last
        expect(user.gitlab_username).to eq "pr. twilight sparkle".gsub(/[^a-zA-Z0-9_\.-]/, "_").force_encoding("utf-8")
        expect(user.email_address).to eq "twilight@example.org"
      end
    end

    context "with invalid new user" do
      it "raises and does not save user" do
        OmniAuth.config.mock_auth[:dice] = :invalid_credentials
        visit '/auth/dice'
        expect(page).to have_content('OmniAuth authentication failed.')
        expect(User.count).to be_zero
      end
    end
  end
end
