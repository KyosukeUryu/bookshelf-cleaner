require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user_a) { FactoryBot.create(:user) }
  let(:finished_book_a) { FactoryBot.create(:finished_book, user: user_a) }
  let(:comment_a) { FactoryBot.create(:comment, finished_book: finished_book_a, user: user_a) }
  it 'contentが空ならバリデーションが通らない' do
    comment_a.content = ''
    expect(comment_a).to be_invalid
  end

  it '問題なく入力されれば登録される' do
    expect(comment_a).to be_valid
  end
end
