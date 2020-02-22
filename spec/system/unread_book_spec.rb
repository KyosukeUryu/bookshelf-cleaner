require 'rails_helper'

describe '未読書籍の管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, email: 'b@example.com') }
  let!(:unread_book_a) { FactoryBot.create(:unread_book, title: '最初の本', user: user_a) }
  let!(:progress_a) { FactoryBot.create(:progress, content: '最初のメモ', user: user_a) }

  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
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

      it '検索欄に適切に入力したときに正しく表示される' do
        fill_in 'キーワード', with: '最初の本'
        click_button '検索'
        expect(page).to have_content '最初の本'
      end

      it '検索ワードが違うとき表示されない' do
        fill_in 'キーワード', with: '違う本'
        click_button '検索'
        expect(page).not_to have_content '最初の本'
      end

      it 'ステータス検索が不適切な時表示されない' do
        select '積読', from: 'ステータス'
        click_button '検索'
        expect(page).not_to have_content '最初の本'
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

    it_behaves_like 'ユーザーAが登録した書籍が表示される'
  end

  describe '読書中書籍機能' do
    let(:login_user) { user_a }
    before do
      visit reading_books_unread_books_path
    end

    context 'ユーザーAがログインしている時' do
      it_behaves_like 'ユーザーAが登録した書籍が表示される'

      it 'ユーザーAが入力したメモが表示される' do
        expect(page).to have_content '最初のメモ'
      end

      describe '進捗メモ作成機能' do
        before do
          fill_in '進捗メモ', with: progress_content
          click_button '追加'
        end

        context '正しく入力されている時' do
          let(:progress_content) { '次のメモ' }

          it 'メモが追加される' do
            expect(page).to have_content '次のメモ'
          end
        end

        context '入力されていない時' do
          let(:progress_content) { '' }

          it 'エラーが発生する' do
            expect(page).to have_content '進捗情報を入力してください'
          end
        end
      end
    end

  end

  describe '未読書籍作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_unread_book_path
      fill_in 'タイトル', with: book_name
      fill_in '著者名', with: book_author
      select '読書中', from: 'ステータス'
      click_button '登録する'
    end

    context '正しく書籍情報が入力されている' do
      let(:book_name) { '正しい書籍' }
      let(:book_author) { '正しい著者' }

      it '書籍情報が登録される' do
        expect(page).to have_content '正しい書籍を未読書籍に登録しました'
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

  describe '未読書籍の検索機能' do
    let(:login_user) { user_a }

    before do
      visit search_unread_book_path
    end
  end

  describe '未読書籍編集機能' do
    let(:login_user) { user_a }

    before do
      visit edit_unread_book_path(unread_book_a)
      fill_in 'タイトル', with: book_name
      fill_in '著者名', with: book_author
      select '読書中', from: 'ステータス'
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
