class ApprovedUser < ApplicationRecord
    validates :user_id, uniqueness: { scope: :approved_user_id }
end
