require 'rails_helper'

describe '未読書籍の管理機能', type: :system do
  describe '未読書籍一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, email: 'a@example.com')
      FactoryBot.create(:unread_book, title: '最初の本', user: user_a)
    end

    context 'ユーザーAがログインしている時' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'Log in'
      end

      it 'ユーザーAが登録した書籍が表示される' do
        visit unread_books_path
        expect(page).to have_content '最初の本'
      end
    end

    context 'ユーザーBがログインしている時' do
      FactoryBot.create(:user, email: 'b@example.com')
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'Log in'
      end

      it 'ユーザーAが登録した書籍が表示されない' do
        visit unread_books_path
        expect(page).not_to have_content '最初の本'
      end
    end
  end
end
