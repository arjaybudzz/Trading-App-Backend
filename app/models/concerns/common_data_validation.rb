module CommonDataValidation
  extend ActiveSupport::Concern

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  included do
    validates :username, presence: true, uniqueness: { case_sensitive: true }
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: true },
                      format: { with: VALID_EMAIL_REGEX }

    has_secure_password
    validates :password, length: { minimum: 8, maximum: 20 }, on: :create
  end
end
