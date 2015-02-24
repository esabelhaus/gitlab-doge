class GitlabToken < GitlabDataAccessor
  pattr_initialize :user_dn

  def token
    GitlabDataAccessor.where(extern_uid: user_dn).first.authentication_token
  end
end
