class User < ApplicationRecord
  has_secure_password

  validates_presence_of :name, :email, :confirmation_token

  after_initialize -> { self.confirmation_token = SecureRandom.urlsafe_base64 }, unless: :confirmation_token?

  booleanable :confirmed
end
