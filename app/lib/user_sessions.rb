module UserSessions
  def sign_in(user, permanent: false)
    @current_user = user
    if permanent
      cookies.permanent.encrypted[:uid] = user.id
    else
      cookies.encrypted[:uid] = user.id
    end
  end

  def sign_out
    @current_user = nil
    cookies.delete :uid
  end

  def current_user
    @current_user ||= User.find_by id: cookies.encrypted[:uid]
  end

  def user_signed_in?
    current_user.present?
  end
end
