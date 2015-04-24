require 'spec_helper'

describe BuildsController, '#create' do
  #pending("need to rewrite stubs for gitlab api")
  context 'when https is enabled' do
    context 'and http is used' do
      it 'does not redirect' do
        allow(JobQueue).to receive(:push)

        with_https_enabled do
          payload_data = File.read(
            'spec/support/fixtures/merge_request_event.json'
          )
          post(:create, payload: payload_data)

          expect(response).not_to be_redirect
        end
      end
    end
  end

  context 'when build is received' do
    it 'enqueues LargeBuildJob' do
      allow(JobQueue).to receive(:push)
      payload_data = File.read(
        'spec/support/fixtures/merge_request_event.json'
      )

      payload = { payload: payload_data, controller: "builds", action: "create" }

      post(:create, payload: payload_data)

      expect(JobQueue).to have_received(:push).with(
        LargeBuildJob, payload
      )
    end
  end
end
