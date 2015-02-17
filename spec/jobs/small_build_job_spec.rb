require 'fast_spec_helper'
require 'app/jobs/buildable'
require 'app/jobs/small_build_job'

describe SmallBuildJob do
  it 'is buildable' do
    expect(SmallBuildJob.new).to be_a(Buildable)
  end
end
