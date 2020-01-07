class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :unread_books, dependent: :destroy
  has_many :finished_books, dependent: :destroy
  has_many :messages, dependent: :destroy
end
