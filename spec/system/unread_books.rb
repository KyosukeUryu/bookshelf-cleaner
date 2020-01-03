require 'rails_helper'

describe '未読書籍の管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, email: 'b@example.com') }
  let!(:unread_book_a) { FactoryBot.create(:unread_book, title: '最初の本', user: user_a) }

  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'Log in'
  end

  describe '未読書籍一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      it 'ユーザーAが登録した書籍が表示される' do
        visit unread_books_path
        expect(page).to have_content '最初の本'
      end
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザーAが登録した書籍が表示されない' do
        visit unread_books_path
        expect(page).not_to have_content '最初の本'
      end
    end
  end

  describe '未読書籍詳細機能' do
    let(:login_user) { user_a }

    before do
      visit unread_book_path(unread_book_a)
    end

    it 'ユーザーAが作成したタスクの詳細が表示される' do
      expect(page).to have_content '最初の本'
    end
  end
end
