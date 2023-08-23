class User < ApplicationRecord
    before_save { self.email = email.downcase }
    before_save { self.name = name.downcase }

    VALID_NAME_REGEX = /\A[a-z\d\-\_]+\z/i
    validates :name,presence:true,
                    uniqueness: true,
                    length: { maximum: 20 }, 
                    format: { with: VALID_NAME_REGEX }
 
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,presence:true,
                     length: { maximum: 255 },
                     format: { with: VALID_EMAIL_REGEX },
                     uniqueness: true

    has_secure_password
    validates :password, length: { maximum: 255 }, length: { minimum: 6 }

end
