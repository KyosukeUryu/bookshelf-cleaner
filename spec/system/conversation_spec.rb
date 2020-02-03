require 'rails_helper'

describe '会話機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'first_man', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'second_man', email: 'b@example.com') }
  let!(:finished_book_b) { FactoryBot.create(:finished_book, title: '処分予定の本', status: 2, user: user_b) }
  let!(:conversation_a) { FactoryBot.create(:conversation, sender: user_a, recipient: user_b )}
  let!(:message_a) { FactoryBot.create(:message, body: '最初のメッセージ', conversation: conversation_a, user: user_b)}

  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'Log in'
  end

  describe '他ユーザーの既読書籍一覧からメッセージ画面に遷移' do
    let(:login_user) { user_a }
    before do
      visit others_finished_books_path
    end

    it 'メッセージを送るボタンを押したらユーザーとのやりとり画面に遷移する' do
      click_on 'メッセージを送る'
      expect(page).to have_content 'second_manさんとのメッセージ'
    end
  end

  describe 'メッセージ投稿機能' do
    let(:login_user) { user_a }
    before do
      visit conversation_messages_path(conversation_a)
      fill_in 'メッセージ', with: message_body
      click_button 'メッセージを送る'
    end

    context 'ユーザーAが投稿したとき' do
      let(:message_body) { '次のメッセージ' }

      it '投稿が完了する' do
        expect(page).to have_content '次のメッセージ'
      end
    end
  end
end

