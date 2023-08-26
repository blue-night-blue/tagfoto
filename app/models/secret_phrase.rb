class SecretPhrase < ApplicationRecord
    belongs_to :user
    
    has_secure_password
    validates :user_id, {uniqueness: true}
    validates :password, {presence: true}
end
