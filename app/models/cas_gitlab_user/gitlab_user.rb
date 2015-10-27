class GitlabUser < ActiveRecord::Base
  self.table_name = "users"
  establish_connection :gitlab
  has_many :gitlab_identities
end