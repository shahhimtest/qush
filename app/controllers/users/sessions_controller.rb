class Users::SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: user_params[:email]

    if @user&.authenticate(user_params[:password])
      if @user.confirmed?
        sign_in @user, permanent: params[:permanent] == '1'

        flash[:success] = 'Successfully signed in.'
        return_back newsfeed_path
      else
        flash[:danger] = 'User not confirmed!'
        redirect_to signin_path
      end
    else
      flash[:danger] = 'Invalid credentials!'
      redirect_to signin_path
    end
  end

  def destroy
    if sign_out
      flash[:info] = 'Signed out!'
      return_back
    else
      flash[:danger] = 'Not signed out!'
      return_back
    end
  end

  private

  def authenticated?
    if create_action?
      return true unless user_signed_in?
    end

    if destroy_action?
      return true if user_signed_in?
    end
  end

  def authorized?
    return true
  end

  def user_params
    return unless params[:user].present?
    params.require(:user).permit(:email, :password)
  end
end
