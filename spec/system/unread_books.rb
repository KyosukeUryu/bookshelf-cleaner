require 'rails_helper'

describe '未読書籍の管理機能', type: :system do
  describe '未読書籍一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, email: 'b@example.com') }

    before do
      FactoryBot.create(:unread_book, title: '最初の本', user: user_a)
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'Log in'
    end

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
end
