class FinishedBook < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :author, presence: true
  enum status: %i[reread keep disposal_soon disposal]
end
