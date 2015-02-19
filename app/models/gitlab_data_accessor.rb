class GitlabDataAccessor < ActiveRecord::Base
  self.abstract_class = true

  self.table_name = "users"

  establish_connection :gitlab
end
