class Post < ApplicationRecord
    has_one_attached :image do |attachable|
        attachable.variant :thumb, resize_to_limit: [300, 300]
    end
    
end
