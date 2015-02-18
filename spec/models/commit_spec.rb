require "fast_spec_helper"
require "attr_extras"
require "app/models/commit"
require "gitlab"


describe Commit do
  describe "#file_content" do
    context "when content is returned from Gitlab" do
      it "returns content" do
        stub_gitlab_commit("1.json", 1)
        commit = Commit.new(1, "master", gitlab_api)

        expect(commit.file_content("1.json")).to eq "some content"
      end
    end

    context "when file contains special characters" do
      it "does not error when linters try writing to disk" do
        stub_gitlab_commit("2.json", 1)
        commit = Commit.new(1, "master", gitlab_api)
        tmp_file = Tempfile.new("foo", encoding: "utf-8")

        expect { tmp_file.write(commit.file_content("2.json")) }.
          not_to raise_error
      end
    end

    context "when content is nil" do
      it "returns blank string" do
        stub_gitlab_commit("3.json", 1)
        commit = Commit.new(1, "master", gitlab_api)

        expect(commit.file_content("3.json")).to eq ""
      end
    end

    context "when error occurs when fetching from Gitlab" do
      pending
      # it "returns blank string" do
      #   stub_gitlab_commit_error("error.json", 1)
      #   commit = Commit.new(1, "master", gitlab_api)
      #
      #   expect(commit.file_content("error.json")).to eq ""
      # end
    end
  end

  def gitlab_api
    @gitlab_api = Gitlab.client(:endpoint => ENV['GITLAB_ENDPOINT'], :private_token => ENV['DOGE_GITLAB_TOKEN'])
  end

end
