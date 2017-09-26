class RelationshipsController < ApplicationController
  before_action :set_relationship, only: :destroy
  before_action :authorize!

  def create
    @relationship = current_user.active_relationships.new relationship_params

    if @relationship.save
      flash[:success] = 'Relationship created!'
      return_back
    else
      flash[:danger] = 'Unable to follow!'
      return_back
    end
  end

  def destroy
    if @relationship.destroy
      flash[:success] = 'Relationship deleted!'
      return_back
    else
      flash[:danger] = 'Unable to unfollow!'
      return_back
    end
  end

  private

  def authorized?
    if create_action?
      return true
    end

    if destroy_action?
      return true if current_user == @relationship.follower
    end
  end

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end

  def set_relationship
    @relationship = Relationship.find(params[:relationship_id] || params[:id])
  end
end
