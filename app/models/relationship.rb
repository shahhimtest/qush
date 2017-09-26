class Relationship < ApplicationRecord
  belongs_to :follower, class_name: :User, counter_cache: :followed_count
  belongs_to :followed, class_name: :User, counter_cache: :follower_count

  validates_uniqueness_of :follower, scope: :followed
end
