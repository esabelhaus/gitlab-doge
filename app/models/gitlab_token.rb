class GitlabToken < ActiveRecord::Base
  self.table_name = "gitlab_identities_gitlab_users"
  belongs_to :gitlab_identities
  belongs_to :gitlab_users

  def self.user(dn)
    GitlabIdentity.where(extern_uid: dn).first.user_id
  end

  def self.token_by_dn(dn)
    GitlabUser.where(id: GitlabToken.user(dn)).first.authentication_token
  end
end