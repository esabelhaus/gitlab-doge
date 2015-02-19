class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:create, :destroy]
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    @omniauth = request.env['omniauth.auth'].to_hash
    user = find_user || create_user
    reset_session
    create_session_for(user)
    redirect_to repos_path
  end

  def destroy
    destroy_session
    redirect_to root_path
  end

  def failure
    flash.now[:error] = "OmniAuth authentication failed."
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def find_user
    User.where(gitlab_username: gitlab_username).first
  end

  def create_user
    user = User.create!(
      gitlab_username: gitlab_username,
      email_address: gitlab_email_address
    )
    flash[:signed_up] = true
    user
  end

  def create_session_for(user)
    session[:remember_token] = user.remember_token
    session[:gitlab_token] = gitlab_token
  end

  def destroy_session
    reset_session
  end

  def gitlab_username
    auth_hash["info"]["common_name"]
  end

  def gitlab_email_address
    auth_hash["info"]["email"]
  end

  def gitlab_token
    return 'some_random_key'
    # FIXME ^^^^
    #auth_hash["credentials"]["token"]
    GitLabDB.find(where: {email: gitlab_email_address})
  end
end
