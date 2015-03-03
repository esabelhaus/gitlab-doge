class AdminConstraint
  def matches?(request)
    return false unless request.session[:remember_token]
    user = User.where(remember_token: request.session[:remember_token])
    user && user.first.is_admin?
  end
end