class ConcernBook < ApplicationRecord
  belongs_to :user
  belongs_to :finished_book
end
