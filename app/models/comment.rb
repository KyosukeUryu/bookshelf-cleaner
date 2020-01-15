# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  content          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  finished_book_id :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_comments_on_finished_book_id  (finished_book_id)
#  index_comments_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (finished_book_id => finished_books.id)
#  fk_rails_...  (user_id => users.id)
#

class Comment < ApplicationRecord
  belongs_to :finished_book
  belongs_to :user
  validates :content, presence: true
end
