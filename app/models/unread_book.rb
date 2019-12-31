class UnreadBook < ApplicationRecord
  enum status: %i[not_yet reading]
end
