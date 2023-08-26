class Post < ApplicationRecord
    belongs_to :user

    has_many_attached :images do |attachable|
        attachable.variant :thumb, resize_to_fill: [150, 150]
    end

    validates :images, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
    
    def self.tags_in_posts(user)
        self.where(user_id:user.id).pluck(:tag).join(",").split(",").map(&:strip).reject(&:empty?).uniq
    end

    VALID_TAG_REGEX = /\A[^\[\]\/\\"$%&'=~|`{*}<>?!^;:.]*\z/i
    validates :tag,  format: { with: VALID_TAG_REGEX }
    
end
