require "spec_helper"

describe HomeController, "#index" do
  context "when https is enabled" do
    before do
      mock_dice
      allow(GitlabToken).to receive(:token_by_dn).and_return('gitlabdogetoken')
    end
    context "and http is used" do
      it "redirects to https" do
        with_https_enabled do
          get :index

          expect(response).to redirect_to(root_url(protocol: "https"))
        end
      end
    end

    context "and https is used" do
      it "does not redirect" do
        with_https_enabled do
          request.env["HTTPS"] = "on"

          get :index

          #should redirect to auth dice
          expect(response).to be_redirect
        end
      end
    end
  end
end
