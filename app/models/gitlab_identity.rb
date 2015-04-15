class GitlabIdentity < ActiveRecord::Base
  self.table_name = "identities"
  establish_connection :gitlab
  belongs_to :gitlab_user
end