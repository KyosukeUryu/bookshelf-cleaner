class FinishedBook < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :concern_books
  validates :title, presence: true
  validates :author, presence: true
  enum status: %i[reread keep disposal_soon disposal]
end
