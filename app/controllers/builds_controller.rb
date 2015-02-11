class BuildsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate, only: [:create]

  def create
    JobQueue.push(build_job_class, payload.data)
    head :ok
  end

  private

  def force_https?
    false
  end

  def build_job_class
    puts '@'*80
    LargeBuildJob
  end

  def payload
    puts '#'*80
    puts @payload.inspect
    puts Payload.new(params).inspect
    @payload ||= Payload.new(params)
  end
end
