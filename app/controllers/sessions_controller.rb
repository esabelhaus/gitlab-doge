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
      email_address: gitlab_email_address,
      dn: auth_hash['uid'],
      gitlab_token: gitlab_token
    )
    flash[:signed_up] = true
    user
  end

  def extern_uid
    # Gitlab username derived from DN
    auth_hash['uid'].to_s.gsub(/[^a-zA-Z0-9_\.-]/, "_").force_encoding("utf-8")
  end


  #auth_hash['extern_uid']
  def gitlab_token
    GitlabToken.new(auth_hash['extern_uid']).token
  end

  def my_gitlab_token
    token = user_gitlab_token
    g = Gitlab.client(:endpoint => ENV['GITLAB_ENDPOINT'], :private_token => token)
    @my_gitlab_token = this_token
  rescue
    @my_gitlab_token = gitlab_token
  end

  def user_gitlab_token
    User.where(gitlab_username: gitlab_username).gitlab_token
  end

  def create_session_for(user)
    session[:remember_token] = user.remember_token
    session[:gitlab_token] = my_gitlab_token
  end

  def destroy_session
    reset_session
  end

  def gitlab_username
    # Gitlab username derived from DN
    auth_hash['uid'].to_s.gsub(/[^a-zA-Z0-9_\.-]/, "_").force_encoding("utf-8")
  end

  def gitlab_email_address
    auth_hash["info"]["email"]
  end
end
