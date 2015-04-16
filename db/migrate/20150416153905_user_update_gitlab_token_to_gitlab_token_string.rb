class UserUpdateGitlabTokenToGitlabTokenString < ActiveRecord::Migration
  def change
    rename_column :users, :gitlab_token, :gitlab_token_string
  end
end
