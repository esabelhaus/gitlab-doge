require 'fast_spec_helper'
require 'app/jobs/buildable'
require 'app/jobs/large_build_job'

describe LargeBuildJob do
  it 'is buildable' do
    expect(LargeBuildJob.new).to be_a(Buildable)
  end
end
