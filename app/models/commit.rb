class Commit
  pattr_initialize :gitlab_repo_id, :sha, :api

  def file_content(filename)
    @api.file_contents(gitlab_repo_id, filename, sha).to_s.force_encoding("UTF-8")
  rescue Gitlab::Error::Error
    ""
  end
end
