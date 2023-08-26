class ApprovedUser < ApplicationRecord
    belongs_to :user
    
    validates :user_id, uniqueness: { scope: :approved_user_id }
end
