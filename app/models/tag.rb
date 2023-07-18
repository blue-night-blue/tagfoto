class Tag < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "group", "id", "number", "tag", "updated_at", "user_id"]
    end    
end
