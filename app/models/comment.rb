class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost, optional: true
  validates :content, presence: true
end
