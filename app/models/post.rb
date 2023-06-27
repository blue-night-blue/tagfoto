class Post < ApplicationRecord

    has_many_attached :images do |attachable|
        attachable.variant :thumb, resize_to_limit: [300, 300]
    end

    validates :images, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
 
    
    
    
    
end
