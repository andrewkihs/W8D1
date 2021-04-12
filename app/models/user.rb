class User < ApplicationRecord

    validates :username, :password_digest, :session_token, presence: true, uniqueness:true
    validates :password, length: {minimum: 6, allow_nil: true}
    after_initialize :ensure_session_token
    attr_reader :password

    has_many :subs,
    foreign_key: :moderator,
    class_name: :Sub

    has_many :posts,
    foreign_key: :author_id,
    class_name: :Post
    
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def is_password?(password)
        pw_object = BCrypt::Password.new(self.password_digest)
        pw_object.is_password?(password)
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end
end