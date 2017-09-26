class NewsfeedController < ApplicationController
  def show
    @messages = current_user.followed_messages.order(created_at: :desc)
  end

  private

  def authorized?
    return true
  end
end
