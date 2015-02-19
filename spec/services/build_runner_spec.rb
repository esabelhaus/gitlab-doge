require 'spec_helper'

describe BuildRunner, '#run' do
  pending("need to rewrite stubs for gitlab api")
  # context 'with active repo and opened merge request' do
  #   it 'creates a build record with violations' do
  #     repo = create(:repo, :active, gitlab_id: 123)
  #     payload = stubbed_payload(
  #       gitlab_repo_id: repo.gitlab_id,
  #       merge_request_number: 5,
  #       head_sha: "123abc",
  #       full_repo_name: repo.name
  #     )
  #     build_runner = BuildRunner.new(payload)
  #     stubbed_style_checker_with_violations
  #     stubbed_commenter
  #     stubbed_merge_request
  #
  #     build_runner.run
  #     build = Build.first
  #
  #     expect(Build.count).to eq 1
  #     expect(build).to eq repo.builds.last
  #     expect(build.violations.size).to be >= 1
  #     expect(build.merge_request_number).to eq 5
  #     expect(build.commit_sha).to eq payload.head_sha
  #   end
  #
  #   it 'comments on violations' do
  #     build_runner = make_build_runner
  #     commenter = stubbed_commenter
  #     style_checker = stubbed_style_checker_with_violations
  #     commenter = Commenter.new(stubbed_merge_request)
  #     allow(Commenter).to receive(:new).and_return(commenter)
  #
  #     build_runner.run
  #
  #     expect(commenter).to have_received(:comment_on_violations).
  #       with(style_checker.violations)
  #   end
  #
  #   it 'initializes StyleChecker with modified files and config' do
  #     build_runner = make_build_runner
  #     merge_request = stubbed_merge_request
  #     stubbed_style_checker_with_violations
  #     stubbed_commenter
  #
  #     build_runner.run
  #
  #     expect(StyleChecker).to have_received(:new).with(merge_request)
  #   end
  #
  #   it 'initializes mergeRequest with payload and Hound token' do
  #     repo = create(:repo, :active, gitlab_id: 123)
  #     payload = stubbed_payload(gitlab_repo_id: repo.gitlab_id)
  #     build_runner = BuildRunner.new(payload)
  #     stubbed_merge_request
  #     stubbed_style_checker_with_violations
  #     stubbed_commenter
  #
  #     build_runner.run
  #
  #     expect(mergeRequest).to have_received(:new).with(payload)
  #   end
  # end
  #
  # context 'without active repo' do
  #   it 'does not attempt to comment' do
  #     repo = create(:repo, :inactive)
  #     build_runner = make_build_runner(repo: repo)
  #     allow(Commenter).to receive(:new)
  #
  #     build_runner.run
  #
  #     expect(Commenter).not_to have_received(:new)
  #   end
  # end
  #
  # context 'without opened or synchronize merge request' do
  #   it 'does not attempt to comment' do
  #     build_runner = make_build_runner
  #     merge_request = stubbed_merge_request
  #     allow(merge_request).
  #       to receive_messages(opened?: false, synchronize?: false)
  #     allow(Commenter).to receive(:new)
  #
  #     build_runner.run
  #
  #     expect(Commenter).not_to have_received(:new)
  #   end
  # end
  #
  # def make_build_runner(repo: create(:repo, :active, gitlab_id: 123))
  #   payload = stubbed_payload(gitlab_repo_id: repo.gitlab_id)
  #   BuildRunner.new(payload)
  # end
  #
  # def stubbed_payload(options = {})
  #   defaults = {
  #     merge_request_number: 123,
  #     head_sha: "somesha",
  #     full_repo_name: "foo/bar"
  #   }
  #   double("Payload", defaults.merge(options))
  # end
  #
  # def stubbed_style_checker_with_violations
  #   violations = [double(:violation)]
  #   style_checker = double(:style_checker, violations: violations)
  #   allow(StyleChecker).to receive(:new).and_return(style_checker)
  #
  #   style_checker
  # end
  #
  # def stubbed_commenter
  #   commenter = double(:commenter).as_null_object
  #   allow(Commenter).to receive(:new).and_return(commenter)
  #
  #   commenter
  # end
  #
  # def stubbed_merge_request
  #   merge_request = double(
  #     :merge_request,
  #     merge_request_files: [double(:file)],
  #     config: double(:config),
  #     opened?: true
  #   )
  #   allow(mergeRequest).to receive(:new).and_return(merge_request)
  #
  #   merge_request
  # end
end
