class UnreadBook < ApplicationRecord
  belongs_to :user
  enum status: %i[not_yet reading]
  validates :title, presence: true
  validates :author, presence: true
  acts_as_taggable
  mount_uploader :image, ImageUploader

  #def self.search(term)
  #  base_uri 'https://www.googleapis.com/books/v1/volumes'
  #  maxResults
  #end
end
