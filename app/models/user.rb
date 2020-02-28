# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  avater                 :text
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :unread_books, dependent: :destroy
  has_many :finished_books, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :concern_books, dependent: :destroy
  has_many :progresses, dependent: :destroy
  has_many :sender_conversations, class_name: 'Conversation', foreign_key: 'sender_id', dependent: :destroy
  has_many :recipient_conversations, class_name: 'Conversation', foreign_key: 'recipient_id', dependent: :destroy

  validates :name, presence: true, length: { maximum: 40 }
  validates :email, length: { maximum: 255 }
  mount_uploader :avater, ImageUploader

  def concerned?(book)
    concern_books.find_by(finished_book_id: book.id)
  end

  def has_tags?
    finished_books.all_tags.present? ? true : false
  end
end
