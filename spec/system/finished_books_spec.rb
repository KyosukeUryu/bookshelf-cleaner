require 'rails_helper'

describe '既読書籍の管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, email: 'b@example.com') }
  let!(:unread_book_a) { FactoryBot.create(:unread_book, title: '最初の本', user: user_a) }
  let!(:finished_book_a) { FactoryBot.create(:finished_book, title: '最初に読み終わった本', user: user_a) }
  let!(:finished_book_b) { FactoryBot.create(:finished_book, title: '処分予定の本', status: 2, user: user_b) }
  let!(:comment_a) { FactoryBot.create(:comment, content: '最初のコメント', user: user_a, finished_book: finished_book_a) }


  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'Log in'
  end

  shared_examples_for 'ユーザーAが登録した書籍が表示される' do
    it { expect(page).to have_content '最初に読み終わった本' }
  end

  describe '既読書籍一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      before do
        visit finished_books_path
      end

      it_behaves_like 'ユーザーAが登録した書籍が表示される'

      it '検索欄に適切に入力したときに正しく表示される' do
        fill_in 'キーワード', with: '最初に読み終わった本'
        click_button '検索'
        expect(page).to have_content '最初に読み終わった本'
      end

      it '検索ワードが違うとき' do
        fill_in 'キーワード', with: '違う本'
        click_button '検索'
        expect(page).not_to have_content '最初に読み終わった本'
      end
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザーAが登録した書籍が表示されない' do
        visit finished_books_path
        expect(page).not_to have_content '最初に読み終わった本'
      end
    end
  end

  describe '既読書籍詳細機能' do
    let(:login_user) { user_a }

    before do
      visit finished_book_path(finished_book_a)
    end

    it_behaves_like 'ユーザーAが登録した書籍が表示される'

    it 'ユーザーAのコメントが確認できる' do
      expect(page).to have_content '最初のコメント'
    end

    describe 'コメント作成機能' do
      before do
        fill_in 'コメント', with: comment_content
        click_button '投稿する'
      end

      context '正しく入力されている時' do
        let(:comment_content) { '次のコメント' }

        it 'コメントが追加される' do
          expect(page).to have_content '次のコメント'
        end
      end

      context '入力されずに投稿しようとした時' do
        let(:comment_content) { '' }

        it 'エラーが発生する' do
          expect(page).to have_content '投稿できませんでした'
        end
      end

    end

  end

  describe '未読書籍を既読書籍に移し替える機能' do
    let(:login_user) { user_a }

    before do
      visit reading_books_unread_books_path
      click_on '読破'
      fill_in 'タイトル', with: book_name
      fill_in '著者名', with: book_author
      select '要再読', from: 'ステータス'
      fill_in '感想等', with: 'very good'
      click_button '登録する'
    end

    context '正しく書籍情報が入力されている' do
      let(:book_name) { '正しい既読書籍' }
      let(:book_author) { '正しい著者' }

      it '書籍情報が登録される' do
        expect(page).to have_content '書籍読破おめでとうございます！'
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

  describe '既読書籍編集画面' do
    let(:login_user) { user_a }

    before do
      visit edit_finished_book_path(finished_book_a)
      fill_in 'タイトル', with: book_name
      fill_in '著者名', with: book_author
      click_button '更新する'
    end

    context '正しく書籍情報が入力されている' do
      let(:book_name) { '編集された書籍' }
      let(:book_author) { '正しい著者' }

      it '書籍情報が更新される' do
        expect(page).to have_content '既読書籍情報を更新しました'
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

  describe '他のユーザーの書籍一覧機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      before do
        visit others_finished_books_path
      end

      it '自分の書籍は表示されない' do
        expect(page).not_to have_content '最初の本'
      end
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }
      before do
        visit others_finished_books_path
      end

      it '他ユーザーの書籍が表示される' do
        expect(page).to have_content '最初に読み終わった本'
      end

      it '検索ワードが違う時書籍が表示されない' do
        fill_in 'キーワード', with: '違う本'
        click_button '検索'
        expect(page).not_to have_content '最初に読み終わった本'
      end
    end
  end

  describe '処分予定書籍一覧' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      before do
        visit disposal_finished_books_path
      end

      it '他のユーザーの処分予定書籍が表示される' do
        expect(page).to have_content '処分予定の本'
      end

      it '検索ワードが違う時書籍が表示されない' do
        fill_in 'キーワード', with: '違う本'
        click_button '検索'
        expect(page).not_to have_content '処分予定の本'
      end
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }
      before do
        visit disposal_finished_books_path
      end

      it '自分の書籍は表示されない' do
        expect(page).not_to have_content '処分予定の本'
      end

    end
  end
end

