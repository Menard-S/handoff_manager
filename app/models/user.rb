class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 8 }, format: { with: /\A(?=.*\d)(?=.*[A-Z])(?=.*[\W]).{8,}\z/, message: "must include at least one lowercase letter, one uppercase letter, one digit, and one special character" }

end


