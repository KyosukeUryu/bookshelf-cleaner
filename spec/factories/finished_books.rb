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

FactoryBot.define do
  factory :finished_book do
    title { 'finished' }
    author { 'done auth' }
    status { 0 }
    impression { 'good book' }
    user
  end
end
