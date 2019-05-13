class User < ApplicationRecord
  has_secure_password

  MIN_PASSWORD_LENGTH = 6

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
    length: { minimum: MIN_PASSWORD_LENGTH },
    on: :create

  scope :by_lower_email, -> (email) {
    where('lower(email) = lower(?)', email)
  }
end
