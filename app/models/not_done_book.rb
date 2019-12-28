class NotDoneBook < ApplicationRecord
  enum status: %i[積読 読書中]
end
