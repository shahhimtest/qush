class Users::RelationshipsController < Users::Base
  def follower
    @follower = @user.follower.paginate(page: params[:page])
  end

  def following
    @following = @user.followed.paginate(page: params[:page])
  end

  private

  def authenticated?
    return true
  end

  def authorized?
    return true
  end
end
