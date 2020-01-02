class UnreadBook < ApplicationRecord
  belongs_to: user
  enum status: %i[not_yet reading]
end
