class Users::Base < ApplicationController
  before_action :set_user
  before_action :authorize!

  private

  def set_user
    @user = User.find params[:user_id] || params[:id]
  end
end
