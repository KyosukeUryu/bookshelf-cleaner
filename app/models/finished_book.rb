# == Schema Information
#
# Table name: finished_books
#
#  id               :bigint           not null, primary key
#  author           :string           not null
#  desposal_expired :date
#  image            :text
#  impression       :text
#  status           :integer          default("reread"), not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint
#
# Indexes
#
#  index_finished_books_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class FinishedBook < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :concern_books
  validates :title, presence: true
  validates :author, presence: true
  acts_as_taggable
  enum status: %i[reread keep disposal_soon disposal]
  mount_uploader :image, ImageUploader
end
