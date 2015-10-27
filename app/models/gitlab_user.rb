require 'gitlab_monkey_patch'
class CasGitlabUser < User
  has_one :cas_gitlab_token

  def set_token
    gitlab_token_string = token
  end

  def token
    GitlabToken.token_by_dn(dn)
  end
end
