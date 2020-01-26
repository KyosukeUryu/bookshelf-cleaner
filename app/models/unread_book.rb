# == Schema Information
#
# Table name: unread_books
#
#  id              :bigint           not null, primary key
#  author          :string           not null
#  image           :text
#  reading_expired :date
#  status          :integer          default("not_yet"), not null
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_unread_books_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class UnreadBook < ApplicationRecord
  belongs_to :user
  enum status: %i[not_yet reading]
  validates :title, presence: true
  validates :author, presence: true
  acts_as_taggable
  mount_uploader :image, ImageUploader

  scope :standard, ->  { order(created_at: :desc)}

end
