class Comment < ApplicationRecord
  belongs_to :finished_book
  belongs_to :user
  validates :content, presence: true
end
