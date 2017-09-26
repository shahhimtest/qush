class Messages::LikesController < Messages::Base
  before_action :set_like, only: :destroy
  before_action :authorize!

  def create
    @like = @message.likes.new user: current_user

    if @like.save
      flash[:success] = 'Message liked!'
      return_back
    else
      flash[:danger] = 'Unable to like!'
      return_back
    end
  end

  def destroy
    if @like.destroy
      flash[:warning] = 'Message unliked!'
      return_back
    else
      flash[:danger] = 'Unable to unlike!'
      return_back
    end
  end

  private

  def set_like
    @like = @message.likes.find_by user: current_user
  end

  def authorized?
    if create_action?
      return true unless @message.likes.find_by user: current_user
    end

    if destroy_action?
      return true if @like.present?
    end
  end
end
