class User < ApplicationRecord
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    
    NAME_MAXIMUM_LENGTH = 50
    PASSWORD_MINIMUM_LENGTH = 6
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    before_save :downcase
    validates :name, presence: true, length: { maximum: NAME_MAXIMUM_LENGTH }
    validates :email, presence: true, format: { with:VALID_EMAIL_REGEX }, 
    uniqueness: true
    validates :password, presence: true, length: { minimum: PASSWORD_MINIMUM_LENGTH }
    
    has_secure_password

    def follow(other_user)
        following << other_user
    end

    def unfollow(other_user)
        following.delete(other_user)
    end

    def following?(other_user)
        following.include?(other_user)
    end

    private 

    def downcase 
     self.email = email.downcase 
    end
end
