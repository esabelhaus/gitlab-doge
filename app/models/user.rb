class User < ActiveRecord::Base
  attr_accessible :github_username

  before_create :generate_remember_token

  def to_s
    github_username
  end

  private

  def generate_remember_token
    self.remember_token = SecureRandom.hex(20)
  end
end