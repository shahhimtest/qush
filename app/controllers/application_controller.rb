class ApplicationController < ActionController::Base
  include UserSessions
  helper UserSessions

  protect_from_forgery with: :exception

  before_action :authenticate!, :authorize!
  before_action :set_return_to_param

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

  def set_return_to_param
    if params[:return_to]
      session[:return_to] = params[:return_to]
    end

    if params[:remove_return_to] == '1'
      session.delete(:return_to)
    end
  end

  def return_back(fallback_url=nil)
    redirect_to session.delete(:return_to) || fallback_url || root_path
  end

  def redirect_back(fallback_location: root_path)
    super(fallback_location: fallback_location)
  end
end
