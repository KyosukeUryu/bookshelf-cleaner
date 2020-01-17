# == Schema Information
#
# Table name: progresses
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_progresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Progress < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  def content_time
    created_at.strftime("%m月%d日 %l:%M %p")
  end
end
