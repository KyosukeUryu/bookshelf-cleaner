require 'rails_helper'

RSpec.describe FinishedBook, type: :model do
  let(:finished_book_a) { FactoryBot.create(:finished_book) }
  it 'titleが空ならバリデーションが通らない' do
    finished_book_a.title = ''
    expect(finished_book_a).to be_invalid
  end

  it 'authorが空ならバリデーションが通らない' do
    finished_book_a.author = ''
    expect(finished_book_a).to be_invalid
  end

  it '感想が３００文字超の時はバリデーションが通らない' do
    long_impression = 'a' * 301
    finished_book_a.impression = long_impression
    expect(finished_book_a).to be_invalid
  end

  it '問題なく入力されれば登録される' do
    expect(finished_book_a).to be_valid
  end
end



