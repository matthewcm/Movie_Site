require_dependency 'app/validators/email_validator'
class User < ActiveRecord::Base
    before_save :downcase_email

    validates :name,  presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 200 }
    validates :email, email: true
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 5 }
    has_secure_password
    private

    def downcase_email
        self.email = email.downcase
    end
end
