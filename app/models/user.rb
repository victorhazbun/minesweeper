class User < ApplicationRecord
  has_secure_password

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
    length: { minimum: 6 },
    if: -> { new_record? || !password.nil? }

  scope :by_lower_email, -> (email) {
    where('lower(email) = lower(?)', email)
  }
end
