require 'fast_spec_helper'
require 'lib/job_queue'

class JobClass
  include Sidekiq::Worker
end

Sidekiq::Testing.fake!

describe JobQueue do
  describe '.push' do
    it 'pushes a job to sidekiq worker' do
      payload = double(:payload)
      
      expect {
      JobQueue.push(JobClass, payload)
      }.to change(JobClass.jobs, :size).by(1)
    end
  end
end
