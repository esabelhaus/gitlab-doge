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

  def update_token
    logger.debug "Verifying access to API"
    Gitlab.client(endpoint: ENV['GITLAB_ENDPOINT'], private_token: gitlab_token)
  rescue
    logger.debug "Gitlab token expired, updating Gitlab API token"
    gitlab_token = GitlabToken.new(gitlab_username).token
    save
  end

  private

  def generate_remember_token
    self.remember_token = SecureRandom.hex(20)
  end
end
