class Comment < ApplicationRecord
  belongs_to :post, touch: true
  belongs_to :author, class_name: 'User'
end
