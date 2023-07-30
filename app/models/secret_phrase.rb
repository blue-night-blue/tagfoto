class SecretPhrase < ApplicationRecord
    has_secure_password
    validates :user_id, {uniqueness: true}
    validates :password, {presence: true}
end
