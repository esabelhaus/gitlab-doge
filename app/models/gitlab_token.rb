class GitlabToken < ActiveRecord::Base
  has_many :gitlab_identities
  has_many :gitlab_users
end