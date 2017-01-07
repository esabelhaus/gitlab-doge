require "fast_spec_helper"
require "app/models/merge_request"
require "app/models/commit"
require "gitlab_monkey_patch"

describe MergeRequest do
  #pending("need to rewrite stubs for gitlab api")
  describe "#opened?" do
    context "when payload action is opened" do
      it "returns true" do
        merge_request = MergeRequest.new(payload_stub(action: "opened"))

        expect(merge_request).to be_opened
      end
    end

    context "when payload action is not opened" do
      it "returns false" do
        payload = payload_stub(action: "notopened")
        merge_request = MergeRequest.new(payload)

        expect(merge_request).not_to be_opened
      end
    end
  end

  describe "#synchronize?" do
    context "when payload action is synchronize" do
      it "returns true" do
        payload = payload_stub(action: "synchronize")
        merge_request = MergeRequest.new(payload)

        expect(merge_request).to be_synchronize
      end
    end

    context "when payload action is not synchronize" do
      it "returns false" do
        payload = payload_stub(action: "notsynchronize")
        merge_request = MergeRequest.new(payload)

        expect(merge_request).not_to be_synchronize
      end
    end
  end

  describe "#comments" do
    it "returns comments on merge request" do
      filename = "spec/models/style_guide_spec.rb"
      comment = double(:comment, position: 7, path: filename)
      gitlab = double(:gitlab, merge_request_comments: [comment])
      merge_request = merge_request_stub(gitlab)

      comments = merge_request.comments

      expect(comments.size).to eq(1)
      expect(comments).to match_array([comment])
    end
  end

  describe "#comment_on_violation" do
    it "posts a comment to gitlab for the Hound user" do
      payload = payload_stub
      gitlab = double(:gitlab_client, add_merge_request_comment: nil)
      merge_request = merge_request_stub(gitlab, payload)
      violation = violation_stub
      commit = double("Commit")
      allow(Commit).to receive(:new).and_return(commit)

      merge_request.comment_on_violation(violation)

      expect(gitlab).to have_received(:add_merge_request_comment).with(
        merge_request_number: payload.merge_request_number,
        commit: commit,
        comment: violation.messages.first,
        filename: violation.filename,
        patch_position: violation.patch_position,
      )
    end
  end

  def violation_stub(options = {})
    defaults =  {
      messages: ["A comment"],
      filename: "test.rb",
      patch_position: 123,
    }
    double("Violation", defaults.merge(options))
  end

  def payload_stub(options = {})
    defaults = {
      full_repo_name: "org/repo",
      head_sha: "1234abcd",
      merge_request_number: 5,
    }
    double("Payload", defaults.merge(options))
  end

  def merge_request_stub(api, payload = payload_stub)
    allow(gitlabApi).to receive(:new).and_return(api)
    MergeRequest.new(payload)
  end
end
