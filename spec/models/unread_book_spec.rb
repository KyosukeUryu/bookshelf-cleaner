require 'rails_helper'

RSpec.describe UnreadBook, type: :model do
  let(:unread_book_a) { FactoryBot.create(:unread_book) }
  it 'titleが空ならバリデーションが通らない' do
    unread_book_a.title = ''
    expect(unread_book_a).to be_invalid
  end

  it 'authorが空ならバリデーションが通らない' do
    unread_book_a.author = ''
    expect(unread_book_a).to be_invalid
  end

  it '問題なく入力されれば登録される' do
    expect(unread_book_a).to be_valid
  end
end


