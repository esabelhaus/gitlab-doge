class CreateJoinTableGitlabIdentityGitlabUser < ActiveRecord::Migration
  def change
    create_join_table :gitlab_identities, :gitlab_users do |t|
      t.index [:gitlab_identity_id, :gitlab_user_id], name: :gitlab_identity_index
    end
  end
end
