class Tag < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "group", "id", "sort_order", "tag", "updated_at", "user_id"]
    end    
end
