require 'gitlab_monkey_patch'
class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  has_many :memberships
  has_many :repos, through: :memberships

  validates :gitlab_username, presence: true

  before_create :generate_remember_token

  def to_s
    gitlab_username
  end

  def github_repo(github_id)
    repos.where(github_id: github_id).first
  end

  def create_github_repo(attributes)
    repos.create(attributes)
  end

  def has_repos_with_missing_information?
    repos.where("private IS NULL").count > 0
  end

  def gitlab_token
    get_current_token # Ensure we always have a current token when invoking
  end

  # Verify connectivity to Gitlab API with current token
  # If token isn't valid, retrieve updated token
  # Return the valid token
  def get_current_token
    Gitlab.client(
      endpoint: ENV['GITLAB_ENDPOINT'],
      private_token: read_attribute(:gitlab_token)
    ).user # Invoke a call to the API to ensure we raise if token is invalid
    return read_attribute(:gitlab_token)
  rescue
    logger.info "Gitlab token expired, updating Gitlab API token"
    write_attribute(:gitlab_token, GitlabToken.new(dn).token)
    read_attribute(:gitlab_token)
  end

  private

  def generate_remember_token
    self.remember_token = SecureRandom.hex(20)
  end
end
