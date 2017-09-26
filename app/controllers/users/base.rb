class Users::Base < ApplicationController
  before_action :set_user
  before_action :authorize!

  private

  def set_user
    if params[:username]
      @user = User.find_by! username: params[:username]
    else
      @user = User.find params[:user_id] || params[:id]
    end
  end
end
