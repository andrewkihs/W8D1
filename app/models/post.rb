class Post < ApplicationRecord
    validates :title, :sub_id, :author_id, presence: true

    belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

    belongs_to :sub,
    foreign_key: :sub_id,
    class_name: :Sub

    before_action :require_logged_in, only: [:create, :edit]

    
end