class ApplicationController < ActionController::Base
  include UserSessions
  helper UserSessions

  protect_from_forgery with: :exception

  before_action :authenticate!, :authorize!

  rescue_from ActionControl::NotAuthenticatedError, with: :user_not_authenticated
  rescue_from ActionControl::NotAuthorizedError, with: :user_not_authorized

  private

  def authenticated?
    return true if user_signed_in?
  end

  def user_not_authenticated
    flash[:danger] = "You are not authenticated!"
    return_back
  end

  def user_not_authorized
    flash[:danger] = "You are not authorized!"
    return_back
  end

  def return_back(fallback_url=nil)
    redirect_to session.delete(:return_to) || fallback_url || root_path
  end
end
