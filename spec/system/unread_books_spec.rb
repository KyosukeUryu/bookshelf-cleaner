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

  shared_examples_for 'ユーザーAが登録した書籍が表示される' do
    it { expect(page).to have_content '最初の本' }
  end

  describe '未読書籍一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      before do
        visit unread_books_path
      end

      it_behaves_like 'ユーザーAが登録した書籍が表示される'
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

    it_behaves_like 'ユーザーAが登録した書籍が表示される'
  end

  describe '未読書籍作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_unread_book_path
      fill_in 'タイトル', with: book_name
      fill_in '著者名', with: book_author
      select 'reading', from: 'ステータス'
      click_button '登録する'
    end

    context '正しく書籍情報が入力されている' do
      let(:book_name) { '正しい書籍' }
      let(:book_author) { '正しい著者' }

      it '書籍情報が登録される' do
        expect(page).to have_content '未読書籍を登録しました'
      end
    end

    context '書籍情報が入力されていない' do
      let(:book_name) { '' }
      let(:book_author) { '正しい著者' }

      it 'エラー情報が表示される' do
        expect(page).to have_content 'タイトルを入力してください'
      end
    end
  end

  describe '未読書籍編集機能' do
    let(:login_user) { user_a }

    before do
      visit edit_unread_book_path(unread_book_a)
      fill_in 'タイトル', with: book_name
      fill_in '著者名', with: book_author
      select 'reading', from: 'ステータス'
      click_button '更新する'
    end

    context '正しく書籍情報が入力されている' do
      let(:book_name) { '編集された書籍' }
      let(:book_author) { '正しい著者' }

      it '書籍情報が更新される' do
        expect(page).to have_content '未読書籍情報を更新しました'
      end
    end

    context '書籍情報が入力されていない' do
      let(:book_name) { '' }
      let(:book_author) { '正しい著者' }

      it 'エラー情報が表示される' do
        expect(page).to have_content 'タイトルを入力してください'
      end
    end
  end
end
