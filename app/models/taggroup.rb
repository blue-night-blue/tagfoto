class Taggroup < ApplicationRecord
    belongs_to :user
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "group", "id", "sort_order", "updated_at", "user_id"]
    end    

    VALID_TAG_REGEX = /\A[^\[\]\/\\"$%&'=~|`{*}<>?!^;:.,]*\z/i
    validates :group, presence:true,
                        length: { maximum: 30 },
                        format: { with: VALID_TAG_REGEX },
                        uniqueness: { scope: :user_id }
  
    
end
