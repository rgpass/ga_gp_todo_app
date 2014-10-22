module SessionsHelper
  def sign_in(user)
    # save a cookie on their computer
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    # update our database with their cookie info
    user.update_attribute(:remember_token, User.digest(remember_token))
    # set a current_user variable equal to user
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    digested_remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: digested_remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
