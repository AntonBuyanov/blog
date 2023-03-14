class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, class_name: 'Post', foreign_key: :author_id
  has_many :comments, class_name: 'Comment', foreign_key: :author_id

  def author?(resource)
    resource.author_id == id
  end
end
