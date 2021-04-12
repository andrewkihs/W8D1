class Sub < ApplicationRecord
    validates :title, :moderator, presence: true, uniqueness: true
    validates :description, presence: true

    belongs_to :moderator,
    foreign_key: :moderator,
    class_name: :User

    has_many :posts,
    foreign_key: :sub_id,
    class_name: :Post
end