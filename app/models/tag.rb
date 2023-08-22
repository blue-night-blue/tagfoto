class Tag < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "group", "id", "sort_order", "tag", "updated_at", "user_id"]
    end    
    
    
    def self.tags_in_tags(user)
        self.where(user_id:user.id).pluck(:tag).map { |tag| [tag, true] }.to_h
    end

    VALID_TAG_REGEX = /\A[^\!\"\$\%\&\'\=\~\|\`\{\*\}\<\>\?\^\[\;\:\]\\\.\/]*\z/i
    validates :tag, length: { maximum: 30 },
                    format: { with: VALID_TAG_REGEX },
                    uniqueness: { scope: :user_id }
    
end
