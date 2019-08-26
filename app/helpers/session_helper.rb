module SessionHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:session_key] = user.session_key
    cookies.encrypted[:session_key] = user.session_key
  end
  def log_out
    session.delete(:user_id)
    session.delete(:session_key)
    cookies.encrypted[:session_key] = nil
  end
  def current_user
  	User.find_by_session_key(session[:session_key])
  end
end
