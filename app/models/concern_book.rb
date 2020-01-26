# == Schema Information
#
# Table name: concern_books
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  finished_book_id :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_concern_books_on_finished_book_id  (finished_book_id)
#  index_concern_books_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (finished_book_id => finished_books.id)
#  fk_rails_...  (user_id => users.id)
#

class ConcernBook < ApplicationRecord
  belongs_to :user
  belongs_to :finished_book

  scope :standard, ->  { order(created_at: :desc)}
end
