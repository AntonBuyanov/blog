class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :author, class_name: 'User'

  has_one_attached :image
end
