class UnreadBook < ApplicationRecord
  belongs_to :user
  enum status: %i[not_yet reading]
  validates :title, presence: true
  validates :author, presence: true
end
