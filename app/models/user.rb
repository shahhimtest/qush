class User < ApplicationRecord
  has_secure_password

  validates_presence_of :name, :email, :confirmation_token
  validates :email, email: true

  after_initialize -> { self.confirmation_token = SecureRandom.urlsafe_base64 }, unless: :confirmation_token?
  before_save { email.downcase! }

  booleanable :confirmed

  has_many :messages, foreign_key: :publisher_id
end
