class AddFollowerCountAndFollowedCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :follower_count, :integer, default: 0
    add_column :users, :followed_count, :integer, default: 0
  end
end
