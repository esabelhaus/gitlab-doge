module AuthenticationHelper
  def stub_sign_in(user, token = doge_token)
    session[:remember_token] = user.remember_token
    session[:gitlab_token] = token
  end

  def sign_in
    mock_dice
    visit root_path
  end
end
