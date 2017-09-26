class User < ApplicationRecord
  has_secure_password

  validates_presence_of :name, :email, :confirmation_token
  validates :email, email: true

  after_initialize -> { self.confirmation_token = SecureRandom.urlsafe_base64 }, unless: :confirmation_token?
  before_save { email.downcase! }

  booleanable :confirmed

  has_many :messages, foreign_key: :publisher_id, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :active_relationships, class_name: :Relationship, foreign_key: :follower_id, dependent: :destroy
  has_many :followed, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: :Relationship, foreign_key: :followed_id, dependent: :destroy
  has_many :follower, through: :passive_relationships, source: :follower
end
