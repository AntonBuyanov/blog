class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :author, class_name: 'User'

  has_many_attached :images, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
end
